class VisionTestsController < ApplicationController
  def sharpness
  end

  def sharpness_start
    directions = %w[up down left right]
    sizes = [ 100, 90, 80, 70, 60, 50, 40, 30, 25, 20 ]
    right_steps = sizes.map { |size| [ directions.sample, size ] }
    left_steps = sizes.map { |size| [ directions.sample, size ] }
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
    direction, size = data[@index]
    image = "tests/sharpnesstest/#{direction}.png"
    @step = SharpnessTestStep.new(image: image, answer: direction, size: size)
  end

  def sharpness_answer
    eye = params[:eye]
    index = params[:step_index].to_i
    user_answer = params[:answer]
    data = session["sharpness_test_#{eye}"]
    redirect_to vision_sharpness_tests_path, alert: "Сесію втрачено" and return unless data
    direction, size = data[index]
    step = SharpnessTestStep.new(image: "tests/sharpnesstest/#{direction}.png", answer: direction, size: size)
    session["sharpness_correct_#{eye}"] += 1 if step.correct?(user_answer)
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

  IMAGE_ANSWERS = {
    "tests/colorblindtest/1.png" => "1",
    "tests/colorblindtest/2.png" => "2",
    "tests/colorblindtest/3.png" => "3",
    "tests/colorblindtest/4.png" => "4",
    "tests/colorblindtest/5.png" => "5",
    "tests/colorblindtest/6.png" => "6",
    "tests/colorblindtest/7.png" => "7",
    "tests/colorblindtest/8.png" => "8",
    "tests/colorblindtest/9.png" => "9",
    "tests/colorblindtest/1alt.png" => "1",
    "tests/colorblindtest/2alt.png" => "2",
    "tests/colorblindtest/3alt.png" => "3",
    "tests/colorblindtest/4alt.png" => "4",
    "tests/colorblindtest/5alt.png" => "5",
    "tests/colorblindtest/6alt.png" => "6",
    "tests/colorblindtest/6plus.png" => "6",
    "tests/colorblindtest/7alt.png" => "7",
    "tests/colorblindtest/8alt.png" => "8",
    "tests/colorblindtest/9plus.png" => "9",
    "tests/colorblindtest/9alt.png" => "9"
  }.freeze

  def color_test
  all_images = IMAGE_ANSWERS.keys.shuffle.first(20)
  session[:question_images] = all_images
  session[:correct_answers] = 0
  @index = 0
  @questions = all_images.map { |img| Question.new(image: img, correct_answer: IMAGE_ANSWERS[img]) }
  end
  def check_color_test
    if session[:question_images].nil?
      redirect_to color_test_path, alert: "Сесію втрачено, будь ласка, почніть тест заново."
      return
    end
    question_images = session[:question_images]
    index = params[:question_index].to_i
    answer = params[:user_answer]
    current_image = question_images[index]
    correct_answer = IMAGE_ANSWERS[current_image]
    is_correct = (correct_answer.strip.downcase == answer.strip.downcase)
    session[:correct_answers] ||= 0
    session[:correct_answers] += 1 if is_correct
    if index + 1 >= question_images.size
      redirect_to result_color_test_path
    else
      @index = index + 1
      @questions = question_images.map { |img| Question.new(image: img, correct_answer: IMAGE_ANSWERS[img]) }
      render :color_test
    end
  end
  def result_color_test
    question_images = session[:question_images] || []
    @total = question_images.size
    @correct = session[:correct_answers] || 0
    @incorrect = @total - @correct
    @percentage = (@correct.to_f / @total * 100).round(1)
    @feedback =
      if @percentage >= 90
        "Чудовий результат! Ваше сприйняття кольорів не викликає занепокоєння."
      elsif @percentage >= 70
        "Непоганий результат. Можливо, є незначні труднощі зі сприйняттям деяких кольорів."
      elsif @percentage >= 50
        "Середній результат. Рекомендується проконсультуватися з офтальмологом для точнішої діагностики."
      else
        "Результат вказує на можливі проблеми з кольоровим зором. Бажано пройти професійне обстеження."
      end
    session.delete(:question_images)
    session.delete(:correct_answers)
  end
end
