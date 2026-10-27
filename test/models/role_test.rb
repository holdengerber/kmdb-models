require "test_helper"

class RoleTest < ActiveSupport::TestCase
  setup do
    Studio.create({ "name" => "Warner Bros." })
    studio = Studio.find_by({ "name" => "Warner Bros." })
    Movie.create({ "title" => "Batman Begins", "year_released" => 2005, "rated" => "PG-13", "studio_id" => studio["id"] })
    Movie.create({ "title" => "The Dark Knight", "year_released" => 2008, "rated" => "PG-13", "studio_id" => studio["id"] })
    Actor.create({ "name" => "Christian Bale", "birth_date" => Date.new(1974, 1, 30) })
    Actor.create({ "name" => "Michael Caine", "birth_date" => Date.new(1933, 3, 14) })

    @batman_begins = Movie.find_by({ "title" => "Batman Begins" })
    @dark_knight = Movie.find_by({ "title" => "The Dark Knight" })
    @bale = Actor.find_by({ "name" => "Christian Bale" })
    @caine = Actor.find_by({ "name" => "Michael Caine" })
  end

  def new_role
    Role.new({ "movie_id" => @batman_begins["id"], "actor_id" => @bale["id"], "character_name" => "Bruce Wayne" })
  end

  test "Every role must have a character name." do
    role = new_role
    role["character_name"] = nil
    assert_not role.save
  end

  test "Every role must have a movie." do
    role = new_role
    role["movie_id"] = nil
    assert_not role.save
  end

  test "Every role must have an actor." do
    role = new_role
    role["actor_id"] = nil
    assert_not role.save
  end

  test "There can't be more than one role with the same character name and movie." do
    new_role.save
    role = new_role
    role["actor_id"] = @caine["id"]
    assert_not role.save
  end

  test "You can find every role in a movie." do
    new_role.save
    Role.create({ "movie_id" => @batman_begins["id"], "actor_id" => @caine["id"], "character_name" => "Alfred" })
    Role.create({ "movie_id" => @dark_knight["id"], "actor_id" => @bale["id"], "character_name" => "Bruce Wayne" })

    roles = Role.where({ "movie_id" => @batman_begins["id"] })
    assert_equal ["Alfred", "Bruce Wayne"], roles.map { |role| role["character_name"] }.sort
  end

  test "You can find every role by an actor." do
    new_role.save
    Role.create({ "movie_id" => @dark_knight["id"], "actor_id" => @bale["id"], "character_name" => "Bruce Wayne" })
    Role.create({ "movie_id" => @batman_begins["id"], "actor_id" => @caine["id"], "character_name" => "Alfred" })

    roles = Role.where({ "actor_id" => @bale["id"] })
    assert_equal [@batman_begins["id"], @dark_knight["id"]], roles.map { |role| role["movie_id"] }.sort
  end
end
