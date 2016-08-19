class Api::V1::DoctorsController < ApplicationController
  rescue_from BetterDoctor::Error, with: :error_message

  def search
    render json: BetterDoctor.search(params[:name])
  end

  def error_message
    render json: {message: "Backend error"}, status: :bad_gateway
  end
end
