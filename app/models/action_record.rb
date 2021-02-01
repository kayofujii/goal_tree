class ActionRecord < ApplicationRecord
    belongs_to :user
    belongs_to :goal
    belongs_to :action
end
