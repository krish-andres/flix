class MoviesController < ApplicationController
  before_action :find_movie, except: [:index, :new, :create]

  def index
    @movies = Movie.released
  end

  def show
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie Updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :cast, :duration, :director, :image_file_name)
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end

end
