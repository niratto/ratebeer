# frozen_string_literal: true

# top level coment
class RatingsController < ApplicationController
  before_action :set_rating, only: [:destroy]
  # GET /breweries
  # GET /breweries.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  #def create
  #  # otetaan luotu reittaus muuttujaan
  #  rating = Rating.create params.require(:rating).permit(:score, :beer_id)
  #
  #  # talletetaan tehty reittaus sessioon
  #  session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
  #
  #  redirect_to ratings_path
  #end

  #def destroy
    # rating = Rating.find(params[:id])
    # rating.delete
    # redirect_to ratings_path

  #  @rating.destroy
  #  respond_to do |format|
  #    format.html do
  #      redirect_to ratings_url,
  #                  notice: 'Rating was successfully destroyed.'
  #    end
  #    format.json { head :no_content }
  #  end
  #end

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
    rating = Rating.find(params[:id])
    rating.delete
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
