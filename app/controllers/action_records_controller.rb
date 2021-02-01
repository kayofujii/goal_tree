class ActionRecordsController < ApplicationController
    def index
        @action_records = ActionRecord.all
    end

    def new
        @action_record = ActionRecord.new
        @goals = current_user.goals
        @actions = current_user.actions
    end

    def create
        @action_record = current_user.action_records.create(action_record_params)

        if @action_record.save
            redirect_to action: :index
        else
            render :new
        end
    end

    def edit
        @action_record = ActionRecord.find(params[:id])
        @goals = current_user.goals
        @actions = current_user.actions
    end

    def update
        @action_record = ActionRecord.find(params[:id])
        @action_record.assign_attributes action_record_params
        if @action_record.save
            redirect_to action: :index
        else
            render :edit
        end
    end

    def destroy
        @action_record = ActionRecord.find(params[:id])
        @action_record.destroy
        redirect_to action_records_url, notice: "削除しました"
    end

    private
    def action_record_params
        params.require(:action_record).permit(
            :action_image, :action_comment, :goal_id, :action_id
        )
    end
end
