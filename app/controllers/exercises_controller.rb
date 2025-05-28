class ExercisesController < ApplicationController
  def relaxation
    @exercises = RelaxationExercise.sequence
  end

  def recovery
    @exercises = RecoveryExercise.sequence
  end
end
