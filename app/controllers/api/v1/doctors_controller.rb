class Api::V1::DoctorsController < ApplicationController
  rescue_from BetterDoctor::Error, with: :error_message

  def search
    name = params[:name]

    if name.present?
      render json: BetterDoctor.search(name)
    else
      render json: {message: "'name' is required"}, status: :bad_request
    end
  end

  def error_message
    render json: {message: "Backend error"}, status: :bad_gateway
  end
end
