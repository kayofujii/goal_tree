class GoalsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @goals = Goal.all
    end

    def new
        @goal = Goal.new
        @goal.actions.build
    end

    def create
        @goal = current_user.goals.create(goal_params)
        if @goal.save
            redirect_to action: :index
        else
            render :new
        end
    end

    def edit
        @goal = Goal.find(params[:id])
    end

    def show
        @goal = Goal.find(params[:id])
        @actions = @goal.actions
        @action_record = ActionRecord.new
    end

    def update
        @goal = Goal.find(params[:id])
        @goal.assign_attributes goal_params
        if @goal.save
            redirect_to action: :index
        else
            render :edit
        end
    end

    def destroy
        @goal = Goal.find(params[:id])
        @goal.destroy
        redirect_to goals_url, notice: "目標を削除しました"
    end

    private
    def goal_params
        params.require(:goal).permit(
            :goal_content,:action_content,:identity_content,:rank,
            actions_attributes: [:action_name, :user_id]
        )
    end
end
