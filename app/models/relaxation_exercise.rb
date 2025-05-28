class RelaxationExercise
  attr_reader :name, :duration, :type, :animation, :description

  def initialize(name:, duration:, type:, description:, animation: nil)
    @name = name
    @duration = duration
    @type = type
    @animation = animation
    @description = description
  end

  def self.sequence
    [
      new(name: "Кліпайте очима", duration: 20, type: :blink, description: "Швидко кліпайте очима, не напружуючи повіки. Це допомагає зволожити очі."),
      new(name: "Закрийте очі", duration: 10, type: :close_eyes, description: "Закрийте очі та розслабте м’язи обличчя. Дихайте глибоко."),
      new(name: "Горизонтальний рух", duration: 30, type: :move, animation: :horizontal, description: "Переміщуйте погляд праворуч та ліворуч, не рухаючи головою."),
      new(name: "Вертикальний рух", duration: 30, type: :move, animation: :vertical, description: "Переміщуйте погляд вгору і вниз, повільно та без напруги."),
      new(name: "Діагональний рух", duration: 30, type: :move, animation: :diagonal_down, description: "Ведіть погляд по діагоналі від лівого верхнього до правого нижнього кута."),
      new(name: "Кліпайте очима", duration: 20, type: :blink, description: "Знову активно кліпайте для зволоження очей."),
      new(name: "Закрийте очі", duration: 10, type: :close_eyes, description: "Закрийте очі та глибоко вдихніть кілька разів."),
      new(name: "Діагональний рух", duration: 30, type: :move, animation: :diagonal_up, description: "Ведіть погляд від правого нижнього до лівого верхнього кута."),
      new(name: "Рух за годинниковою стрілкою", duration: 40, type: :move, animation: :circle_clockwise, description: "Опишіть очима повне коло за годинниковою стрілкою."),
      new(name: "Рух проти годинникової стрілки", duration: 40, type: :move, animation: :circle_counter, description: "Опишіть очима повне коло проти годинникової стрілки."),
      new(name: "Кліпайте очима", duration: 20, type: :blink, description: "На завершення ще раз активно покліпайте."),
      new(name: "Закрийте очі", duration: 10, type: :close_eyes, description: "Закрийте очі та дайте їм відпочити.")
    ]
  end
end
