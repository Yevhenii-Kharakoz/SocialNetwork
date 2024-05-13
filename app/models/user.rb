class User < ApplicationRecord
  # Devise модули
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # Валидации
  validates :city, presence: true


  # Ассоциации
  has_many :posts
  has_many :comments

  # Колбэки
  before_save :assign_admin_role
  before_save :set_country
  has_many :availabilities

  # Методы класса для Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id role_cont role_eq role_start role_end password_digest_eq bio_cont bio_eq bio start password_digest_start password_digest_end reset_password_token_cont reset_password_token_eq reset_password_token_start reset_password_token_end confirmation_token_cont confirmation_token_eq confirmation_token_start confirmation_token_end unconfirmed_email_cont unconfirmed_email_eq unconfirmed_email_start unconfirmed_email_end admin_eq name password_digest_cont email city country created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[posts comments]
  end

  def admin?
    role == 'admin'
  end

  private

  def assign_admin_role
    self.role = 'admin' if email.ends_with?('@karazin.ua')
    self.admin = email.ends_with?('@karazin.ua')
  end

  def set_country
    results = Geocoder.search(self.city)
    if results.first
      self.country = results.first.country
    end
  end
end