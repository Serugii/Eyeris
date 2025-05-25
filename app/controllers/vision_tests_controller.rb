class VisionTestsController < ApplicationController
  def sharpness
  end

  def color_blindness
  end

  def duochrome
  end

  def syvtsevs
  end

  def color_test
    all_questions = [
      Question.new(image: "tests/colorblindtest/1.png", correct_answer: "1"),
      Question.new(image: "tests/colorblindtest/2.png", correct_answer: "2"),
      Question.new(image: "tests/colorblindtest/3.png", correct_answer: "3"),
      Question.new(image: "tests/colorblindtest/4.png", correct_answer: "4"),
      Question.new(image: "tests/colorblindtest/5.png", correct_answer: "5"),
      Question.new(image: "tests/colorblindtest/6.png", correct_answer: "6"),
      Question.new(image: "tests/colorblindtest/7.png", correct_answer: "7"),
      Question.new(image: "tests/colorblindtest/8.png", correct_answer: "8"),
      Question.new(image: "tests/colorblindtest/9.png", correct_answer: "9"),
      Question.new(image: "tests/colorblindtest/1alt.png", correct_answer: "1"),
      Question.new(image: "tests/colorblindtest/2alt.png", correct_answer: "2"),
      Question.new(image: "tests/colorblindtest/3alt.png", correct_answer: "3"),
      Question.new(image: "tests/colorblindtest/4alt.png", correct_answer: "4"),
      Question.new(image: "tests/colorblindtest/5alt.png", correct_answer: "5"),
      Question.new(image: "tests/colorblindtest/6alt.png", correct_answer: "6"),
      Question.new(image: "tests/colorblindtest/6plus.png", correct_answer: "6"),
      Question.new(image: "tests/colorblindtest/7alt.png", correct_answer: "7"),
      Question.new(image: "tests/colorblindtest/8alt.png", correct_answer: "8"),
      Question.new(image: "tests/colorblindtest/9plus.png", correct_answer: "9"),
      Question.new(image: "tests/colorblindtest/9alt.png", correct_answer: "9")
    ]
    @questions = all_questions.shuffle.first(20)
    session[:questions] = @questions.map { |q| { image: q.image, correct_answer: q.correct_answer } }
    session[:correct_answers] = 0
    @index = 0
  end
  def check_color_test
    if session[:questions].nil?
      redirect_to color_test_path, alert: "Сесію втрачено, будь ласка, почніть тест заново."
      return
    end
    questions = session[:questions].map { |q| Question.new(image: q["image"], correct_answer: q["correct_answer"]) }
    index = params[:question_index].to_i
    answer = params[:user_answer]
    result = questions[index].correct?(answer)
    if result
      session[:correct_answers] ||= 0
      session[:correct_answers] += 1
    end
    if index + 1 >= questions.size
      redirect_to result_color_test_path
    else
      @questions = questions
      @index = index + 1
      render :color_test
    end
  end
  def result_color_test
    if session[:questions].nil? || session[:questions].empty?
      redirect_to color_test_path, alert: "Сесію втрачено. Будь ласка, пройдіть тест заново."
      return
    end
    @total = session[:questions].size
    @correct = session[:correct_answers] || 0
    @incorrect = @total - @correct
    @percentage = (@correct.to_f / @total * 100).round(1)
    if @percentage >= 90
      @feedback = "Чудовий результат! Ваше сприйняття кольорів не викликає занепокоєння."
    elsif @percentage >= 70
      @feedback = "Непоганий результат. Можливо, є незначні труднощі зі сприйняттям деяких кольорів."
    elsif @percentage >= 50
      @feedback = "Середній результат. Рекомендується проконсультуватися з офтальмологом для точнішої діагностики."
    else
      @feedback = "Результат вказує на можливі проблеми з кольоровим зором. Бажано пройти професійне обстеження."
    end
    session.delete(:questions)
    session.delete(:correct_answers)
  end
end
