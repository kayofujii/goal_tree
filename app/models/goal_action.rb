class GoalAction < ApplicationRecord
    validates :action_name, presence: true

    belongs_to :user, optional: true
    belongs_to :goal, optional: true

    has_many :action_records, dependent: :destroy
end
