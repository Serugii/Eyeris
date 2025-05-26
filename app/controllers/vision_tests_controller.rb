class VisionTestsController < ApplicationController
  def sharpness
  end

  def sharpness_start
    steps = [
      { image: "tests/sharpnesstest/up.png", answer: "up" },
      { image: "tests/sharpnesstest/down.png", answer: "down" },
      { image: "tests/sharpnesstest/left.png", answer: "left" },
      { image: "tests/sharpnesstest/right.png", answer: "right" }
    ]
    sizes = [ 100, 90, 80, 70, 60, 50, 40, 30, 25, 20 ]
    right_steps = sizes.map do |size|
      step = steps.sample
      { image: step[:image], answer: step[:answer], size: size }
    end
    left_steps = sizes.map do |size|
      step = steps.sample
      { image: step[:image], answer: step[:answer], size: size }
    end
    session[:sharpness_test_right] = right_steps
    session[:sharpness_test_left] = left_steps
    session[:sharpness_correct_right] = 0
    session[:sharpness_correct_left] = 0
    redirect_to sharpness_test_path(eye: "right", index: 0)
  end

  def sharpness_test
    @eye = params[:eye]
    @index = params[:index].to_i
    data = session["sharpness_test_#{@eye}"]
    redirect_to vision_sharpness_tests_path, alert: "Сесію втрачено" and return unless data
    step_data = data[@index]
    @step = SharpnessTestStep.new(
      image: step_data["image"],
      answer: step_data["answer"],
      size: step_data["size"]
    )
  end

  def sharpness_answer
    eye = params[:eye]
    index = params[:step_index].to_i
    user_answer = params[:answer]
    data = session["sharpness_test_#{eye}"]
    redirect_to vision_sharpness_tests_path, alert: "Сесію втрачено" and return unless data
    step_data = data[index]
    step = SharpnessTestStep.new(image: step_data["image"], answer: step_data["answer"], size: step_data["size"])
    if step.correct?(user_answer)
      session["sharpness_correct_#{eye}"] += 1
    end
    if index + 1 < data.size
      redirect_to sharpness_test_path(eye: eye, index: index + 1)
    elsif eye == "right"
      redirect_to sharpness_test_path(eye: "left", index: 0)
    else
      redirect_to sharpness_result_path
    end
  end

  def sharpness_result
    @total = 10
    @right_score = session[:sharpness_correct_right] || 0
    @left_score = session[:sharpness_correct_left] || 0
    @right_percentage = (@right_score.to_f / @total * 100).round(1)
    @left_percentage = (@left_score.to_f / @total * 100).round(1)
    def calculate_sharpness(score)
      case score
      when 10 then "1.0 (норма)"
      when 9 then "0.9"
      when 8 then "0.8"
      when 7 then "0.7"
      when 6 then "0.6"
      when 5 then "0.5"
      when 4 then "0.4"
      when 3 then "0.3"
      when 2 then "0.2"
      when 1 then "0.1"
      else "0.0"
      end
    end
    @right_sharpness = calculate_sharpness(@right_score)
    @left_sharpness = calculate_sharpness(@left_score)
    session.delete(:sharpness_test_right)
    session.delete(:sharpness_test_left)
    session.delete(:sharpness_correct_right)
    session.delete(:sharpness_correct_left)
  end

  def color_blindness
  end

  def duochrome
    @step = params[:step] || "start"
  end

  def duochrome_answer
    if params[:answer].blank?
      flash[:alert] = "Помилка! Будь ласка, оберіть варіант перед переходом далі."
      return redirect_to duochrome_test_path(step: params[:eye])
    end
    session[:duochrome] ||= {}
    session[:duochrome][params[:eye]] = params[:answer]
    if params[:eye] == "right"
      redirect_to duochrome_test_path(step: "left")
    else
      redirect_to result_duochrome_test_path
    end
  end

  def result_duochrome_test
    answers = session[:duochrome]
    if answers.nil?
      redirect_to duochrome_test_path, alert: "Сесію втрачено. Пройдіть тест заново."
      return
    end
    @result = DuochromeResult.new(
      right_answer: answers["right"],
      left_answer: answers["left"]
    )
    session.delete(:duochrome)
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
