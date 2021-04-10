class GoalsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :edit, :destroy, :user]
    before_action :correct_user, only: [:edit, :update]
    
    def index
        @goal_categories = GoalCategory.all
        if params[:search].present?
            @goals = Goal.where('goal_content LIKE ?', "%#{params[:search]}%").order(rank: "DESC")
        elsif params[:goal_category_id].present?
            @goal_category = GoalCategory.find(params[:goal_category_id])
            @goals = @goal_category.goals.order(rank: "DESC")
        else
            #rank順に並べる
            @goals = Goal.order(rank: "DESC")
        end
    end

    def new
        @goal = Goal.new
        @goal.goal_actions.build
    end

    def create
        @goal = current_user.goals.create(goal_params)
        if @goal.save
            redirect_to action: :index
            flash[:success] = "保存しました"
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
        if @goal.save && @goal.user_id == current_user.id
            redirect_to action: :index
            flash[:success] = "保存しました"
        else
            render :edit
        end
    end

    def destroy
        @goal = Goal.find(params[:id])
        if @goal.user_id == current_user.id
            @goal.destroy
            redirect_to goals_url
            flash[:warning] = "目標を削除しました"
        end
    end

    def user
        #目標が最新のもの順に並べる
        @goals = Goal.where(user_id: current_user.id).order(id: "DESC")
    end

    def tumiage
        @action_records = ActionRecord.all.order(id: "DESC")
    end

    private
    def goal_params
        params.require(:goal).permit(
            :goal_content,:identity_content,:rank,:goal_category_id,
            goal_actions_attributes: [:id, :action_name, :user_id]
        )
    end

    def correct_user
        @user = Goal.find(params[:id]).user
        redirect_to(root_path) unless current_user?(@user)
    end
end
