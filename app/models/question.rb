class Question
  attr_reader :image, :correct_answer
  def initialize(image:, correct_answer:)
    @image = image
    @correct_answer = correct_answer
  end
  def correct?(user_answer)
    user_answer.to_s.strip == correct_answer.to_s.strip
  end
end
