# frozen_string_literal: true

# top level coment
class RatingsController < ApplicationController
  before_action :set_rating, only: [:destroy]
  # GET /breweries
  # GET /breweries.json
  def index
    @last5ratings = Rating.last5
    @ratings = Rating.all
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_styles = Style.top 3
    @most_active = User.most_active 3
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rating
    @rating = Rating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def rating_params
    params.require(:rating).permit(:score, :beer_id)
  end
end
