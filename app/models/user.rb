class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, 
    format: { with: /\A[a-zA-Z0-9_]{5,15}\z/, message:"は英数字、アンダースコアで5文字以上15文字以内にする必要があります"}
  validates :display_name, presence: true,
    length: { maximum: 50 }
  validates :description, length: { maximum: 200 }

  has_many :goals, dependent: :destroy
  has_many :goal_actions, dependent: :destroy
  has_many :action_records, dependent: :destroy

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
end
