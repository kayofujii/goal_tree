class GoalActionsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :edit, :destroy]
    before_action :correct_user, only: [:edit, :update]

    def index
        @goal = Goal.find(params[:goal_id])
        @goal_actions = @goal.goal_actions
    end

    def new
        @goal_action = GoalAction.new
        @goal = Goal.find(params[:goal_id])
        @user = @goal.user
        redirect_to(root_path) unless current_user?(@user)
    end

    def create
        @goal_action = GoalAction.new(goal_action_params)
        @goal = Goal.find(params[:goal_id])
        @goal_action.user_id = current_user.id
        @goal_action.goal_id = params[:goal_id]

        if @goal_action.save
            redirect_to action: :index
            flash[:success] = "保存しました"
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
        if @goal_action.save
            redirect_to goal_goal_actions_path(@goal)
            flash[:success] = "保存しました"
        else
            redirect_back(fallback_location: root_path)
            flash[:warning] = "保存できませんでした"
        end
    end

    def destroy
        @goal_action = GoalAction.find(params[:id])
        @goal = @goal_action.goal
        if @goal_action.user_id == current_user.id
            @goal_action.destroy
            redirect_to goal_goal_actions_path(@goal)
            flash[:warning] = "行動を削除しました"
        end
    end

    private
    def goal_action_params
        params.require(:goal_action).permit(
            :action_name, :goal_id)
    end

    def correct_user
        @user = GoalAction.find(params[:id]).user
        redirect_to(root_path) unless current_user?(@user)
    end
end
