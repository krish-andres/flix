require 'spec_helper'

describe ReviewsController do
  
  before { @movie = Movie.create!(movie_attributes) } 

  context "when not signed in" do
    
    before { session[:user_id] = nil } 

    it "cannot access index" do
      get :index, movie_id: @movie
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access new" do
      get :new, movie_id: @movie
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access create" do
      post :create, movie_id: @movie
      expect(response).to redirect_to(signin_url)
    end
  end
end
