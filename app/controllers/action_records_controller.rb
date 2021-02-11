class ActionRecordsController < ApplicationController
    def index
        @goal = Goal.find(params[:goal_id])
        @action_records = @goal.action_records.all
    end

    def new
        @action_record = ActionRecord.new
        @goals = current_user.goals
        @goal_actions = current_user.goal_actions
    end

    def create
        @action_record = ActionRecord.new(action_record_params)
        @action_record.user_id = current_user.id
        @action_record.goal_id = params[:goal_id]

        if @action_record.save
            redirect_to action: :index
        else
            render :index
        end
    end

    def edit
        @action_record = ActionRecord.find(params[:id])
        @goals = @action_record.goal
        @goal_actions = current_user.goal_actions
    end

    def update
        @action_record = ActionRecord.find(params[:id])
        @goal = @action_record.goal
        @action_record.assign_attributes action_record_params
        if @action_record.save
            redirect_to goal_action_records_path(@goal)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @action_record = ActionRecord.find(params[:id])
        @goal = @action_record.goal
        @action_record.destroy
        redirect_to goal_action_records_path(@goal), notice: "削除しました"
    end

    private
    def action_record_params
        params.require(:action_record).permit(
            :action_image, :action_comment, :goal_action_id
        )
    end
end
