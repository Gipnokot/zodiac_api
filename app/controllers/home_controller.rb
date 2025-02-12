class HomeController < ApplicationController
  def index
    current_year = Date.current.year

    @current_zodiac = Zodiac.where(start_date: Date.new(2025, 1, 1)..Date.new(2025, 12, 31))
                            .find_by_start_date(Date.today)

    @zodiac_by_date = Zodiac.where(start_date: Date.new(2025, 1, 1)..Date.new(2025, 12, 31))
                            .find_by_start_date(Date.parse("2025-04-20"))

    @zodiac_date_range = Zodiac.where(start_date: Date.new(2025, 1, 1)..Date.new(2025, 12, 31))
                               .find_by(name: "Aries")
  end
end
