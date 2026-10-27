require "test_helper"

class MovieTest < ActiveSupport::TestCase
  setup do
    Studio.create({ "name" => "Warner Bros." })
    @studio = Studio.find_by({ "name" => "Warner Bros." })
  end

  def new_movie
    Movie.new({
      "title" => "Batman Begins",
      "year_released" => 2005,
      "rated" => "PG-13",
      "studio_id" => @studio["id"],
      "director" => "Christopher Nolan"
    })
  end

  test "Every movie must have a title." do
    movie = new_movie
    movie["title"] = nil
    assert_not movie.save
  end

  test "Every movie must have a year." do
    movie = new_movie
    movie["year_released"] = nil
    assert_not movie.save
  end

  test "Every movie must have a rating." do
    movie = new_movie
    movie["rated"] = nil
    assert_not movie.save
  end

  test "Every movie must have a studio from studio table." do
    gone = Studio.create({ "name" => "Closed Studio" })
    gone_id = gone["id"]
    gone.destroy

    missing = new_movie
    missing["studio_id"] = nil
    assert_not missing.save

    unknown = new_movie
    unknown["studio_id"] = gone_id
    assert_not unknown.save
  end

  test "Every movie must have a director." do
    movie = new_movie
    movie["director"] = nil
    assert_not movie.save
  end

  test "There can’t be more than one movie with the same id." do
    first = new_movie
    first.save
    second = new_movie
    second["title"] = "The Dark Knight"
    second["id"] = first["id"]
    assert_raises(ActiveRecord::RecordNotUnique) { second.save }
  end

  test "There can’t be more than one movie with the same title and year and studio." do
    new_movie.save
    assert_not new_movie.save
  end

  test "Find every movie a studio has made." do
    Studio.create({ "name" => "Paramount" })
    paramount = Studio.find_by({ "name" => "Paramount" })

    new_movie.save
    dark_knight = new_movie
    dark_knight["title"] = "The Dark Knight"
    dark_knight["year_released"] = 2008
    dark_knight.save
    Movie.create({ "title" => "Interstellar", "year_released" => 2014, "rated" => "PG-13", "studio_id" => paramount["id"], "director" => "Christopher Nolan" })

    movies = Movie.where({ "studio_id" => @studio["id"] })
    assert_equal ["Batman Begins", "The Dark Knight"], movies.map { |movie| movie["title"] }.sort
  end

  test "Find every movie a director has made." do
    new_movie.save
    dark_knight = new_movie
    dark_knight["title"] = "The Dark Knight"
    dark_knight["year_released"] = 2008
    dark_knight.save
    Movie.create({ "title" => "Joker", "year_released" => 2019, "rated" => "R", "studio_id" => @studio["id"], "director" => "Todd Phillips" })

    movies = Movie.where({ "director" => "Christopher Nolan" })
    assert_equal ["Batman Begins", "The Dark Knight"], movies.map { |movie| movie["title"] }.sort
  end
end
