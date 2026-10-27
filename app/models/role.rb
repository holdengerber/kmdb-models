class Role < ApplicationRecord
  validates :character_name, presence: true, uniqueness: { scope: :movie_id }
  validates :movie_id, presence: true
  validates :actor_id, presence: true
  validate :movie_must_exist
  validate :actor_must_exist

  def movie_must_exist
    if self["movie_id"] && Movie.find_by({ "id" => self["movie_id"] }) == nil
      errors.add(:movie_id, "must be a movie in the movies table")
    end
  end

  def actor_must_exist
    if self["actor_id"] && Actor.find_by({ "id" => self["actor_id"] }) == nil
      errors.add(:actor_id, "must be an actor in the actors table")
    end
  end
end
