class Api::V1::ZodiacsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # action to display the zodiac sign of the current date
  api :GET, "/api/v1/current_date_zodiac_sign", "Get the zodiac sign for the current date"
  description "This method returns the zodiac sign corresponding to the current date."
  example '{
    "id": 1,
    "name": "Aries",
    "start_date": "2023-03-21",
    "end_date": "2023-04-19"
  }'
  error 404, "Zodiac sign not found for the current date."

  def current_date_zodiac_sign
    zodiac = Zodiac.for_date(Date.today)
    if zodiac.present?
      render json: zodiac, only: [ :id, :name, :start_date, :end_date ]
    else
      render json: { error: "Zodiac sign not found for current date!" }, status: :not_found
    end
  end

  # action to search for a zodiac sign by user-specified date
  api :GET, "/api/v1/zodiac_sign_by_date", "Get the zodiac sign for a specified date"
  param :date, String, required: true, desc: "The date in YYYY-MM-DD format to get the zodiac sign."
  description "This method returns the zodiac sign corresponding to the provided date."
  example '{
    "id": 1,
    "name": "Taurus",
    "start_date": "2023-04-20",
    "end_date": "2023-05-20"
  }'
  error 400, "Invalid date format. Please use the YYYY-MM-DD format."
  error 404, "Zodiac sign not found for the specified date."

  def zodiac_sign_by_date
    date = parse_date(params[:date])
    unless date
      render json: { error: "Invalid date format. Please use the format YYYY-MM-DD." }, status: :bad_request
      return
    end

    zodiac = Zodiac.for_date(date)
    if zodiac.present?
      render json: zodiac, only: [ :id, :name, :start_date, :end_date ]
    else
      render json: { error: "Zodiac sign not found for the specified date!" }, status: :not_found
    end
  end

  # the action returns the date range corresponding to the passed zodiac sign
  api :GET, "/api/v1/date_range_by_sign", "Get the date range for a zodiac sign"
  param :sign, String, required: true, desc: "The name of the zodiac sign."
  description "This method returns the date range for the provided zodiac sign."
  example '{
    "name": "Pisces",
    "start_date": "2023-02-19",
    "end_date": "2023-03-20"
  }'
  error 400, "The sign parameter is required."
  error 404, "Zodiac sign not found."

  def date_range_by_sign
    if params[:sign].blank?
      return render json: { error: "Sign parameter is required" }, status: :bad_request
    end

    zodiac = Zodiac.find_by(name: params[:sign])
    if zodiac
      render json: { name: zodiac.name, start_date: zodiac.start_date, end_date: zodiac.end_date }
    else
      render json: { error: "Zodiac sign not found!" }, status: :not_found
    end
  end

  private

  # Helper method to parse the date string
  def parse_date(date_str)
    Date.parse(date_str) rescue nil
  end
end
