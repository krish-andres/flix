class Movie < ActiveRecord::Base

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
    
end
