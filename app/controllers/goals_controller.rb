class GoalsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @goal_categories = GoalCategory.all
        if params[:search].present?
            @goals = Goal.where('goal_content LIKE ?', "%#{params[:search]}%")
        elsif params[:goal_category_id].present?
            @goal_category = GoalCategory.find(params[:goal_category_id])
            @goals = @goal_category.goals.order(created_at: :desc).all
        else
            @goals = Goal.all
        end
    end

    def new
        @goal = Goal.new
        @goal_categories = GoalCategory.all
        @goal.goal_actions.build
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
        @goal_categories = GoalCategory.all
    end

    def show
        @goal = Goal.find(params[:id])
        @goal_actions = @goal.goal_actions
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

    def user
        @goals = Goal.where(user_id: current_user.id)
    end

    private
    def goal_params
        params.require(:goal).permit(
            :goal_content,:identity_content,:rank,:goal_category_id,
            goal_actions_attributes: [:action_name, :user_id]
        )
    end
end
