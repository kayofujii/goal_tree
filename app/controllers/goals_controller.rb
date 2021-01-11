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

    private
    def goal_params
        params.require(:goal).permit(:goal_content,:action_content,:identity_content,:rank)
    end
end
