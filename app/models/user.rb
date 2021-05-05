class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: %i[twitter google_oauth2 facebook]

  validates :name, presence: true, uniqueness: true, 
    format: { with: /\A[a-zA-Z0-9_]{5,50}\z/, message:"は英数字、アンダースコアで5文字以上50文字以内にする必要があります"}
  validates :display_name, presence: true,
    length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  validates :password, presence: true, on: :create

  has_many :goals, dependent: :destroy
  has_many :goal_actions, dependent: :destroy
  has_many :action_records, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  has_many :messages

  mount_uploader :icon, IconUploader

  accepts_nested_attributes_for :goal_actions

  attr_writer :login

  def login
    @login || self.name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { :value => login }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.without_sns_data(auth, current_user)
    user = current_user || User.where(email: auth.info.email).first
    # 普通のアカウントを持っているけど、snsのアカウント連携はしていない場合
    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        nickname: auth.info&.nickname,
        user_id: user.id
      )
    else
    # 普通のアカウントをもっておらず、snsのアカウント連携もしていない場合
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        name: User.dummy_name(auth),
        display_name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        nickname: auth.info&.nickname,
        user_id: user.id
      )
    end
    return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
    #sns連携済みの場合
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        name: User.dummy_name(auth),
        display_name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
    return {user: user}
  end

  def self.find_oauth(auth, current_user)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth, current_user)[:user]
      sns = user.sns_credentials.where(uid: uid, provider: provider).first
    end
    return { user: user ,sns: sns}
  end

  def self.dummy_name(auth)
    #providerがtwitterで、同じユーザーネームが登録されていない場合、Twitterのユーザーネームで登録する
    if auth.provider == "twitter" && User.find_by(name:auth.info.nickname).blank?
      "#{auth.info.nickname}"
    else
      "#{auth.uid}#{auth.provider}"
    end
  end
end
