class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy 
  has_many :fans, through: :favorites, source: :user


  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, allow_blank: true, format: { 
    with: /\w+.(gif|jpg|png)\z/i, 
    message: "must reference a GIF, JPG, or PNG image" 
  } 
  RATINGS = %w[G PG PG-13 R NC-17]
  validates :rating, inclusion: { in: RATINGS } 

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def self.released
    where("released_on <= ?", Date.today).order("released_on DESC")
  end

  def self.hit
    where("total_gross >= ?", 300000000).order("total_gross DESC")
  end

  def self.flop
    where("total_gross <= ?", 50000000).order("total_gross")
  end

  def self.recently_added
    order("created_at DESC").limit(3)
  end

  def self.this_century
    where("released_on >= ?", '2000-01-01').order("released_on DESC")
  end
    
  def average_stars
    reviews.average(:stars)
  end

end
