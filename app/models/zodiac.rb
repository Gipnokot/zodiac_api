class Zodiac < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.for_date(date)
    find_by("start_date <= ? AND end_date >= ?", date, date)
  end
end
