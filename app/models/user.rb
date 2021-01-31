class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :description, length: { maximum: 200 }

  has_many :goals

  mount_uploader :icon, IconUploader
end
