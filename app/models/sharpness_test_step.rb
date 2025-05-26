class SharpnessTestStep
  attr_reader :image, :answer, :size

  def initialize(image:, answer:, size:)
    @image = image
    @answer = answer
    @size = size
  end

  def correct?(user_answer)
    user_answer.to_s.downcase.strip == answer
  end
end
