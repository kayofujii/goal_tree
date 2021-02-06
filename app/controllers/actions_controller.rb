class ActionsController < ApplicationController
    def index
        @goal = Goal.find(params[:goal_id])
        @actions = @goal.actions
        @action = Action.new
    end

    def new
        @goal = Goal.find(params[:goal_id])
        @action = Action.new
    end

    def create
        @action = Action.new(action_params)
        @action.user_id = current_user.id
        @action.goal_id = params[:goal_id]

        if @action.save
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
    def action_params
        binding.pry
        params.require(:action).permit(
            :action_name, :goal_id)
        # .merge(goal_id: params[goal.id], user_id: current_user.id)
    end
end
