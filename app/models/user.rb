class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :strong_password, if: :password_required?
  def strong_password
    return if password.blank?
    unless password =~ /(?=.*[a-z])/
      errors.add(:password, "має містити хоча б одну маленьку літеру")
      return
    end
    unless password =~ /(?=.*[A-Z])/
      errors.add(:password, "має містити хоча б одну велику літеру")
      return
    end
    unless password =~ /(?=.*\d)/
      errors.add(:password, "має містити хоча б одну цифру")
      return
    end
    unless password =~ /(?=.*[^A-Za-z0-9])/
      errors.add(:password, "Пароль має містити хоча б один спеціальний символ")
    end
  end
end
