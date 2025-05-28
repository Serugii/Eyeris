class RecoveryExercise
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
      new(name: "Фокус на зникаючих колах", duration: 40, type: :move, animation: :focus_pop, description: "Фокусуйте погляд на колі, яке з'являється в різних частинах екрану."),
      new(name: "Вісімка горизонтальна", duration: 40, type: :move, animation: :horizontal_eight, description: "Слідкуйте поглядом за уявною вісімкою, що лежить горизонтально."),
      new(name: "Переміщення погляду у сторони", duration: 30, type: :move, animation: :horizontal, description: "Повільно переміщуйте погляд ліворуч і праворуч, не рухаючи головою."),
      new(name: "Фокусування на центрі", duration: 40, type: :move, animation: :focus_shrink, description: "Сфокусуйте погляд на колі, яке зменшується."),
      new(name: "Кліпайте очима", duration: 20, type: :blink, description: "Швидко кліпайте очима, не напружуючи повіки. Це допомагає зволожити очі."),
      new(name: "Переміщення погляду по квадрату", duration: 40, type: :move, animation: :square, description: "Ведіть погляд по траєкторії квадрата: вгору, вправо, вниз, вліво."),
      new(name: "Фокус на зникаючих колах", duration: 40, type: :move, animation: :focus_pop, description: "Фокусуйте погляд на колі, яке з'являється в різних частинах екрану."),
      new(name: "Рух очей по вертикальній вісімці", duration: 40, type: :move, animation: :vertical_eight, description: "Опишіть очима вісімку, розміщену вертикально."),
      new(name: "Завершення (розслаблення)", duration: 20, type: :close_eyes, description: "Закрийте очі, розслабтеся та дихайте повільно.")
    ]
  end
end
