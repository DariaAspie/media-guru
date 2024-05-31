# frozen_string_literal: true

require 'fileutils'

class UsersControlController < ApplicationController
  before_action :set_user, only: :destroy
  before_action :set_users, only: :indexv
  before_action :set_user_sessions, only: :user_activity_report

  def index
    @users = SearchUserService.new(
      search_params:
    ).call.page(params[:page]).per(params[:per_page])
  end

  def show; end

  def destroy
    flash_message =
      if @user.role == 'user'
        @user.destroy ? { notice: 'Пользователь успешно удален.' } : { error: 'Не удалось удалить пользователя.' }
      else
        { error: 'Административный аккаунт можно удалить только через настройки этого аккаунта.' }
      end

    redirect_to '/users_control/index', flash: flash_message
  end

  def user_activity_report
    @user_sessions.each_value do |data|
      data[:total_time] /= 60
    end

    @user_sessions = @user_sessions.sort_by do |_user_id, data|
      data[:total_time]
    end

    videos_by_day = ActiveRecord::Base.connection.execute("
      SELECT DATE(watched_videos.created_at) AS view_date, COUNT(watched_videos.id) AS views_count
      FROM watched_videos
      GROUP BY view_date
      ORDER BY views_count DESC
    ")

    @daily_views = videos_by_day.each_with_object({}) do |row, hash|
      view_date = row['view_date']
      views_count = row['views_count']

      hash[view_date] = views_count
    end

    total_time_users = @user_sessions.partition { |_user_id, data| (data[:total_time]).positive? }

    users_with_time = total_time_users[0].size
    users_without_time = total_time_users[1].size + User.left_joins(:user_activities)
                                                        .where(user_activities: { user_id: nil }).count

    @user_activity_metrics = { "Посещали": users_with_time, "Не посещали": users_without_time }

    @user_activity = { visited: users_with_time, not_visited: users_without_time }

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'user_activity_report',
               template: 'users_control/user_activity_report',
               encoding: 'utf8'
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.all.page(params[:page]).per(params[:per_page])
  end

  def set_user_sessions
    @user_sessions = UserActivity.order(:created_at).each_with_object({}) do |activity, sessions|
      sessions[activity.user_id] ||= { user_id: activity.user_id, total_time: 0 }

      if activity.action == 'login'
        sessions[activity.user_id][:login_time] = activity.login_time
      elsif activity.action == 'logout' && sessions[activity.user_id].present? && sessions[activity.user_id][:login_time].present?
        sessions[activity.user_id][:total_time] += (activity.logout_time - sessions[activity.user_id][:login_time])
      end
    end
  end

  def search_params
    params.permit(:search)
  end
end
