class Api::V1::DoctorsController < ApplicationController
  def search
    render json: BetterDoctor.search(params[:name])
  end
end
