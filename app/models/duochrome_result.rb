class DuochromeResult
  attr_reader :right_answer, :left_answer

  def initialize(right_answer:, left_answer:)
    @right_answer = right_answer
    @left_answer = left_answer
  end

  def interpretation(eye, answer)
    case answer
    when "red"
      "#{eye} — чіткіше на червоному фоні: можлива короткозорість."
    when "green"
      "#{eye} — чіткіше на зеленому фоні: можлива далекозорість."
    when "equal"
      "#{eye} — однаково на обох фонах: зір у межах норми."
    else
      "#{eye} — немає даних."
    end
  end

  def summary
    [
      interpretation("Праве око", right_answer),
      interpretation("Ліве око", left_answer)
    ]
  end
end
