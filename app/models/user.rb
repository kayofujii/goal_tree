class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :description, length: { maximum: 200 }

  has_many :goals, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :action_records, dependent: :destroy

  mount_uploader :icon, IconUploader

  accepts_nested_attributes_for :actions
end
