class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @movie.favorites.create!(user: current_user)
    redirect_to @movie
  end

  def destroy
    current_favorite = current_user.favorites.find(params[:id])
    current_favorite.destroy
    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
