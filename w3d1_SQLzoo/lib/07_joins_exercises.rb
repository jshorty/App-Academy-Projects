# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      movies.title
    FROM
      actors INNER JOIN castings
      ON actors.id = castings.actor_id
      INNER JOIN movies
      ON castings.movie_id = movies.id
    WHERE
      actors.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      movies.title
    FROM
      actors INNER JOIN castings
      ON actors.id = castings.actor_id
      INNER JOIN movies
      ON castings.movie_id = movies.id
    WHERE
      actors.name = 'Harrison Ford' AND castings.ord > 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      movies.title, actors.name
    FROM
      actors INNER JOIN castings
      ON actors.id = castings.actor_id
      INNER JOIN movies
      ON castings.movie_id = movies.id
    WHERE movies.yr = 1962 AND castings.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      travolta_by_year.yr, total_films
    FROM
      (SELECT
        movies.yr, COUNT(movies.title) AS total_films
      FROM
        actors INNER JOIN castings
        ON actors.id = castings.actor_id
        INNER JOIN movies
        ON castings.movie_id = movies.id
      WHERE
        actors.name = 'John Travolta'
      GROUP BY
        movies.yr) AS travolta_by_year
    WHERE
      travolta_by_year.total_films > 1
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      andrews_films.title, actors.name
    FROM
      (SELECT
        castings.movie_id AS id, movies.title AS title
      FROM
        actors INNER JOIN castings
        ON actors.id = castings.actor_id
        INNER JOIN movies
        ON castings.movie_id = movies.id
      WHERE
        actors.name = 'Julie Andrews') AS andrews_films
      INNER JOIN castings
        ON andrews_films.id = castings.movie_id
      INNER JOIN actors
        ON castings.actor_id = actors.id
    WHERE
      castings.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      starring_roles.name
    FROM
      (
        SELECT
          actors.name AS name, SUM(castings.ord) AS sum
        FROM
          actors INNER JOIN castings
          ON actors.id = castings.actor_id
        WHERE
          castings.ord = 1
        GROUP BY
          actors.name
      ) AS starring_roles
    WHERE
      starring_roles.sum >= 15
    ORDER BY
      starring_roles.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      movies.title, COUNT(castings.actor_id) AS actors
    FROM
      movies JOIN castings
      ON movies.id = castings.movie_id
    WHERE
      movies.yr = 1978
    GROUP BY
      movies.title
    ORDER BY
      actors DESC, movies.title


  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      actors.name
    FROM (
      SELECT
        castings.actor_id AS id
      FROM (
      SELECT
        castings.movie_id AS movie_id
      FROM
        actors INNER JOIN castings
        ON actors.id = castings.actor_id
      WHERE
        actors.name = 'Art Garfunkel') AS art_movies
        INNER JOIN castings
        ON art_movies.movie_id = castings.movie_id) AS co_stars
        INNER JOIN actors
        ON actors.id = co_stars.id
    WHERE
      actors.name != 'Art Garfunkel'
    GROUP BY
      actors.name
  SQL
end
