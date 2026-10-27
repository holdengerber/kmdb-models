class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: [:year_released, :studio_id] }
  validates :year_released, presence: true
  validates :rated, presence: true
  validates :studio_id, presence: true
  validates :director, presence: true
  validate :studio_must_exist

  def studio_must_exist
    if self["studio_id"] && Studio.find_by({ "id" => self["studio_id"] }) == nil
      errors.add(:studio_id, "must be a studio in the studios table")
    end
  end
end
