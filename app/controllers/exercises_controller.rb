class ExercisesController < ApplicationController
  def relaxation
    @exercises = RelaxationExercise.sequence
  end

  def recovery
  end
end
