class Goal < ApplicationRecord
    validates :goal_content, presence: true
    validates :action_content, presence: true
    validates :identity_content, presence: true
    validates :rank, presence: true
end
