require "test_helper"

class StudioTest < ActiveSupport::TestCase
  test "Every studio must have a name." do
    studio = Studio.new
    assert_not studio.save
  end

  test "There can't be more than one studio with the same id." do
    first = Studio.create({ "name" => "Warner Bros." })
    second = Studio.new({ "name" => "Paramount" })
    second["id"] = first["id"]
    assert_raises(ActiveRecord::RecordNotUnique) { second.save }
  end

  test "There can't be more than one studio with the same name." do
    Studio.create({ "name" => "Warner Bros." })
    studio = Studio.new({ "name" => "Warner Bros." })
    assert_not studio.save
  end
end
