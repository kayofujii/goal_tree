class GoalsController < ApplicationController
    def index
        @goals = Goal.all
    end

    def new
        @goal = Goal.new
    end

    def create
        @goal = Goal.new(goal_params)

        if @goal.save
            redirect_to action: :index
        else
            redirect_to action: :new
        end
    end

    def edit
        @goal = Goal.find(params[:id])
    end

    def update
        @goal = Goal.find(params[:id])
        @goal.assign_attributes goal_params
        if @goal.save
            redirect_to action: :index
        else
            redirect_to action: :edit
        end
    end

    def destroy
        @goal = Goal.find(params[:id])
        @goal.destroy
        redirect_to goals_url, notice: "目標を削除しました"
    end

    private
    def goal_params
        params.require(:goal).permit(:goal_content,:action_content,:identity_content,:rank)
    end
end
