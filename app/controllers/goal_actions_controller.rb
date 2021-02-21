class GoalActionsController < ApplicationController
    def index
        @goal = Goal.find(params[:goal_id])
        @goal_actions = @goal.goal_actions
    end

    def new
        @goal = Goal.find(params[:goal_id])
        @goal_action = GoalAction.new
    end

    def create
        @goal_action = GoalAction.new(goal_action_params)
        @goal_action.user_id = current_user.id
        @goal_action.goal_id = params[:goal_id]

        if @goal_action.save
            redirect_to action: :index
        else
            render :new
        end
    end

    def edit
        @goal_action = GoalAction.find(params[:id])
        @goal = @goal_action.goal
    end

    def update
        @goal_action = GoalAction.find(params[:id])
        @goal = @goal_action.goal
        @goal_action.assign_attributes goal_action_params
        if @goal_action.save && @goal_action.user_id == current_user.id
            redirect_to goal_goal_actions_path(@goal)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @goal_action = GoalAction.find(params[:id])
        @goal = @goal_action.goal
        if @goal_action.user_id == current_user.id
            @goal_action.destroy
            redirect_to goal_goal_actions_path(@goal), notice: "目標を削除しました"
        end
    end

    private
    def goal_action_params
        params.require(:goal_action).permit(
            :action_name, :goal_id)
    end
end
