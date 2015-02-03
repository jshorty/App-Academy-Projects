# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp >
        (SELECT
          gdp
        FROM
          countries
        WHERE
          continent = 'Europe'
          AND gdp IS NOT NULL
        ORDER BY
          gdp DESC
        LIMIT 1
        )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT
    countries.continent, countries.name, max_area.area
  FROM
    (SELECT   continent AS continent, MAX(area) AS area
    FROM     countries
    GROUP BY continent) AS max_area
    JOIN countries
    ON max_area.continent = countries.continent AND max_area.area = countries.area

  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
      SELECT
        name, MAX(c.population)
      FROM
      (SELECT
        *
      FROM
        (SELECT
          continent, MAX(population) AS pop
        FROM
          countries
        GROUP BY
          continent) AS a
        RIGHT OUTER JOIN
        (SELECT name, population
          FROM countries) AS b
        ON a.pop = b.population) AS c
      WHERE
        c.pop IS NULL
      GROUP BY
        continent



  SQL
end
