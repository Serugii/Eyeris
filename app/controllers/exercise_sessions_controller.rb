class ExerciseSessionsController < ApplicationController
  before_action :authenticate_user!

  def create
    session = current_user.exercise_sessions.build(
      category: params[:category],
      duration: params[:duration],
      performed_at: Time.zone.parse(params[:performed_at])
    )

    if session.save
      render json: { status: "ok" }
    else
      render json: { status: "error", errors: session.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
