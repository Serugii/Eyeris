class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
    @sessions = @user.exercise_sessions.order(performed_at: :desc)
    @last_activity_date = @sessions.first&.performed_at
    @total_duration = @sessions.sum(:duration)
    @rest_duration = @sessions.where(category: "rest").sum(:duration)
    @recovery_duration = @sessions.where(category: "recovery").sum(:duration)
    counts = ExerciseSession
      .where(user: current_user)
      .group("DATE(performed_at)", :category)
      .count
    grouped_data = counts
      .group_by { |(date, _), _| date }
      .transform_values do |entries|
        rest_count = entries.find { |(_, cat), _| cat == "rest" }&.last || 0
        recovery_count = entries.find { |(_, cat), _| cat == "recovery" }&.last || 0
        {
          rest: rest_count,
          recovery: recovery_count
        }
      end
    @activity_data = grouped_data
  end
end
