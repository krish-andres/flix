class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy 
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  validates :title, presence: true, uniqueness: true
  validates :duration, presence: true
  validates :released_on, presence: true
  validates :slug, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, allow_blank: true, format: { 
    with: /\w+.(gif|jpg|png)\z/i, 
    message: "must reference a GIF, JPG, or PNG image" 
  } 

  RATINGS = %w[G PG PG-13 R NC-17]

  validates :rating, inclusion: { in: RATINGS } 

  before_validation :generate_slug

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  scope :released, -> { where("released_on <= ?", Date.today).order("released_on DESC") }
  scope :hits, -> { released.where("total_gross >= ?", 300000000).order("total_gross DESC") }
  scope :flops, -> { released.where("total_gross <= ?", 50000000).order("total_gross ASC") }
  scope :upcoming, -> { where("released_on >= ?", Date.today).order("released_on ASC") }
  scope :rated, ->(rating) { released.where("rating = ?", rating) }
  scope :recent, ->(max=5) { released.limit(max) }

  def self.recently_added
    order("created_at DESC").limit(3)
  end

  def self.this_century
    where("released_on >= ?", '2000-01-01').order("released_on DESC")
  end
    
  def average_stars
    reviews.average(:stars)
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= title.parameterize if title
  end

end
