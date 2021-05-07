class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @goals = @user.goals.order(rank: "DESC").page(params[:goal_page])
        @action_records = @user.action_records.order(id: "DESC").page(params[:action_record_page])
    end
end
