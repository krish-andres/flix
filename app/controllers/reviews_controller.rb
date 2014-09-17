class ReviewsController < ApplicationController
  before_action :find_movie

  def index
    @reviews = @movie.reviews
  end


  private
  def find_movie
    @movie = Movie.find(params[:movie_id])
  end
end
