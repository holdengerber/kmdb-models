# Builds the KMDB data from scratch and prints the Movies and Top Cast reports.
# Run with: bin/rails runner report.rb

# Delete every row first, so this can run more than once.
Role.destroy_all
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all

# Studio
Studio.create({ "name" => "Warner Bros." })
warner = Studio.find_by({ "name" => "Warner Bros." })

# Movies
Movie.create({ "title" => "Batman Begins", "year_released" => 2005, "rated" => "PG-13", "studio_id" => warner["id"], "director" => "Christopher Nolan" })
Movie.create({ "title" => "The Dark Knight", "year_released" => 2008, "rated" => "PG-13", "studio_id" => warner["id"], "director" => "Christopher Nolan" })
Movie.create({ "title" => "The Dark Knight Rises", "year_released" => 2012, "rated" => "PG-13", "studio_id" => warner["id"], "director" => "Christopher Nolan" })

# Actors (DONE.md requires a birth date, which "The data" doesn't give)
Actor.create({ "name" => "Christian Bale", "birth_date" => "1974-01-30" })
Actor.create({ "name" => "Michael Caine", "birth_date" => "1933-03-14" })
Actor.create({ "name" => "Liam Neeson", "birth_date" => "1952-06-07" })
Actor.create({ "name" => "Katie Holmes", "birth_date" => "1978-12-18" })
Actor.create({ "name" => "Gary Oldman", "birth_date" => "1958-03-21" })
Actor.create({ "name" => "Heath Ledger", "birth_date" => "1979-04-04" })
Actor.create({ "name" => "Aaron Eckhart", "birth_date" => "1968-03-12" })
Actor.create({ "name" => "Maggie Gyllenhaal", "birth_date" => "1977-11-16" })
Actor.create({ "name" => "Tom Hardy", "birth_date" => "1977-09-15" })
Actor.create({ "name" => "Joseph Gordon-Levitt", "birth_date" => "1981-02-17" })
Actor.create({ "name" => "Anne Hathaway", "birth_date" => "1982-11-12" })

# Roles: each movie's top cast, in billing order
casts = {
  "Batman Begins" => [
    ["Christian Bale", "Bruce Wayne"],
    ["Michael Caine", "Alfred"],
    ["Liam Neeson", "Ra's Al Ghul"],
    ["Katie Holmes", "Rachel Dawes"],
    ["Gary Oldman", "Commissioner Gordon"]
  ],
  "The Dark Knight" => [
    ["Christian Bale", "Bruce Wayne"],
    ["Heath Ledger", "Joker"],
    ["Aaron Eckhart", "Harvey Dent"],
    ["Michael Caine", "Alfred"],
    ["Maggie Gyllenhaal", "Rachel Dawes"]
  ],
  "The Dark Knight Rises" => [
    ["Christian Bale", "Bruce Wayne"],
    ["Gary Oldman", "Commissioner Gordon"],
    ["Tom Hardy", "Bane"],
    ["Joseph Gordon-Levitt", "John Blake"],
    ["Anne Hathaway", "Selina Kyle"]
  ]
}

for title, cast in casts
  movie = Movie.find_by({ "title" => title })
  for actor_name, character_name in cast
    actor = Actor.find_by({ "name" => actor_name })
    Role.create({ "movie_id" => movie["id"], "actor_id" => actor["id"], "character_name" => character_name })
  end
end

# Movies report
puts "Movies"
puts "======"
puts ""

movies = Movie.order("year_released")
for movie in movies
  studio = Studio.find_by({ "id" => movie["studio_id"] })
  puts "#{movie["title"].ljust(23)}#{movie["year_released"].to_s.ljust(15)}#{movie["rated"].ljust(7)}#{studio["name"].ljust(14)}#{movie["director"]}"
end

# Top Cast report
puts ""
puts "Top Cast"
puts "========"
puts ""

for movie in movies
  roles = Role.where({ "movie_id" => movie["id"] }).order("id")
  for role in roles
    actor = Actor.find_by({ "id" => role["actor_id"] })
    puts "#{movie["title"].ljust(23)}#{actor["name"].ljust(22)}#{role["character_name"]}"
  end
end
