# Definition of done

What must be true for each model, one sentence per line, under its heading. Plain English,
no Ruby. Write the rules, not the columns: what can't be allowed, what can't be duplicated,
what must you be able to find? Every story in the README should be something these
sentences make true.

This file is yours. Your agent reads it and writes one test for each sentence, named with that
sentence. It doesn't write here. Whether every sentence got its test is yours to check.

## Studio
Every studio must have a name.
There can't be more than one studio with the same id.
There can't be more than one studio with the same name.

## Movie
Every movie must have a title.
Every movie must have a year.
Every movie must have a rating.
Every movie must have a studio from studio table.
Every movie must have a director.
There can’t be more than one movie with the same id.
There can’t be more than one movie with the same title and year and studio.
Find every movie a studio has made.
Find every movie a director has made.

## Actor
Every actor must have a name.
Every actor must have a birth date.
There can't be more than one actor with the same id.
There can’t be more than one actor with the same name and birth date.

## Role
Every role must have a character name.
Every role must have a movie from the movie table.
Every role must have an actor from the actor table.
There can't be more than one role with the same character name and movie.
You can find every role in a movie.
You can find every role by an actor.
