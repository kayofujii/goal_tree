class ActionRecord < ApplicationRecord
    belongs_to :user
    belongs_to :goal
    belongs_to :goal_action

    mount_uploader :action_image, IconUploader
end
