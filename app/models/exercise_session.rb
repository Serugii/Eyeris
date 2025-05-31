class ExerciseSession < ApplicationRecord
  belongs_to :user

  validates :category, inclusion: { in: %w[rest recovery] }

  validates :category, :duration, :performed_at, presence: true
end
