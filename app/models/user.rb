class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 8, allow_blank: true }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: true

  before_save :format_username
  before_validation :generate_slug

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end

  scope :by_name, -> { order("name ASC") } 
  scope :non_admin, -> { by_name.where(admin: false) }

  def format_username
    self.username = username.downcase
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= username.parameterize if username
  end
end
