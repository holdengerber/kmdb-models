require "test_helper"

class ActorTest < ActiveSupport::TestCase
  def new_actor
    Actor.new({ "name" => "Christian Bale", "birth_date" => Date.new(1974, 1, 30) })
  end

  test "Every actor must have a name." do
    actor = new_actor
    actor["name"] = nil
    assert_not actor.save
  end

  test "Every actor must have a birth date." do
    actor = new_actor
    actor["birth_date"] = nil
    assert_not actor.save
  end

  test "There can't be more than one actor with the same id." do
    first = new_actor
    first.save
    second = Actor.new({ "name" => "Michael Caine", "birth_date" => Date.new(1933, 3, 14) })
    second["id"] = first["id"]
    assert_raises(ActiveRecord::RecordNotUnique) { second.save }
  end

  test "There can’t be more than one actor with the same name and birth date." do
    new_actor.save
    assert_not new_actor.save
  end
end
