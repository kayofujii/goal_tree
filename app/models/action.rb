class Action < ApplicationRecord
    # validates :action_name, presence: true

    belongs_to :user, optional: true
    belongs_to :goal, optional: true
end
