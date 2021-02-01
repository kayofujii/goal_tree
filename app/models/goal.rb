class Goal < ApplicationRecord
    validates :goal_content, presence: true
    validates :action_content, presence: true
    validates :identity_content, presence: true
    validates :rank, presence: true

    belongs_to :user

    has_many :actions, dependent: :destroy

    accepts_nested_attributes_for :actions
end
