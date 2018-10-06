# frozen_string_literal: true

# top-level comment
class PlacesController < ApplicationController
  def index; end

  def search
    @weathers = ApixuApi.weather_in(params[:city])
    @places = BeermappingApi.places_in(params[:city])

    if @weathers.empty?
      redirect_to places_path, notice: "No weather in #{params[:city]}"
    elsif @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @places = BeermappingApi.bar_info(params[:id])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:id]}"
    else
      #render :index
    end
  end
end