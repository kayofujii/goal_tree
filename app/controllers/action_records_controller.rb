class ActionRecordsController < ApplicationController
    # after_action :update_goal_rank, only: %i[create update destroy]

    def index
        @goal = Goal.find(params[:goal_id])
        @action_records = @goal.action_records.all
    end

    def new
        @action_record = ActionRecord.new
        @goal = Goal.find(params[:goal_id])
        @goal_actions = @goal.goal_actions
    end

    def create
        @action_record = ActionRecord.new(action_record_params)
        @action_record.user_id = current_user.id
        @action_record.goal_id = params[:goal_id]
        @goal = Goal.find(params[:goal_id])
        if @action_record.save
            redirect_to root_path,
            success: "保存しました"
        else
            render :new
        end
        update_goal_rank
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
        if @action_record.save && @action_record.user_id == current_user.id
            redirect_to goal_action_records_path(@goal), 
            success: "保存しました"
        else
            redirect_back(fallback_location: root_path)
        end
        update_goal_rank
    end

    def destroy
        @action_record = ActionRecord.find(params[:id])
        @goal = @action_record.goal
        if @action_record.user_id == current_user.id
            @action_record.destroy
            update_goal_rank
            redirect_to goal_action_records_path(@goal), success: "削除しました"
        end
    end

    def update_goal_rank
        @action_records = @goal.action_records.all
        case @action_records.count
        when 1
            @goal.update(rank:1)
            flash[:info] = "達成ランクが1になりました"
        when 2
            @goal.update(rank:2)
            flash[:info] = "達成ランクが2になりました"
        when 3
            @goal.update(rank:3)
            flash[:info] = "達成ランクが3になりました"
        when 5
            @goal.update(rank:4)
            flash[:info] = "達成ランクが4になりました"
        when 8
            @goal.update(rank:5)
            flash[:info] = "達成ランクが5になりました"
        when 13
            @goal.update(rank:6)
            flash[:info] = "達成ランクが6になりました"
        when 21
            @goal.update(rank:7)
            flash[:info] = "達成ランクが7になりました"
        when 34
            @goal.update(rank:8)
            flash[:info] = "達成ランクが8になりました"
        else
            nil
        end
    end

    private
    def action_record_params
        params.require(:action_record).permit(
            :action_image, :action_comment, :goal_action_id
        )
    end
end
