class GoalActionsController < ApplicationController
    def index
        @goal = Goal.find(params[:goal_id])
        @goal_actions = @goal.goal_actions
        # @goal_actions = GoalAction.new
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
        # @goal = Goal.find(params[:id])
    end

    def update
        # @goal = Goal.find(params[:id])
        # @goal.assign_attributes goal_params
        # if @goal.save
        #     redirect_to action: :index
        # else
        #     render :edit
        # end
    end

    def destroy
        # @goal = Goal.find(params[:id])
        # @goal.destroy
        # redirect_to goals_url, notice: "目標を削除しました"
    end

    private
    def goal_action_params
        params.require(:goal_action).permit(
            :action_name, :goal_id)
        # .merge(goal_id: params[goal.id], user_id: current_user.id)
    end
end
