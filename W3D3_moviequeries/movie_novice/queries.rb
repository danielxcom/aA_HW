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
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer


def find_angelina
  #find Angelina Jolie by name in the actors table

  # find_by
  # Finds the first record matching the specified conditions.
  # There is no implied ordering so if order matters, you should specify it yourself.
  # If no record is found, returns nil.

  # Actor.find_by name: 'Angelina Jolie'
  Actor.find_by(name: 'Angelina Jolie')
end

def top_titles
  # get movie titles from movies with scores greater than or equal to 9
  # hint: use 'select' and 'where'

  # .select
#   By default, Model.find selects all the fields from the result set using select *.
#
# To select only a subset of fields from the result set, you can specify the subset via the select method.
#
# For example, to select only viewable_by and locked columns:

#Client.select("viewable_by, locked")
#SELECT viewable_by, locked FROM clients

#.where
# Client.find_by first_name: 'Lifo'
# # => #<Client id: 1, first_name: "Lifo">
# Client.where(first_name: 'Lifo').take

  Movie
  .select(:id, :title)
  .where("score = ?", 9)
end



def star_wars
  #display the id, title and year of each Star Wars movie in movies.
  # hint: use 'select' and 'where'

  # What they don't want.
  # Movie.select(:id, :title).where(:score).having("score > ?", 9)

  # Do want.
  # this holds extra quote with \' something \'
  Movie
    .select(:id, :title, :yr)
    .where('title LIKE \'Star Wars%\'')
end


def below_average_years
  #display each year with movies scoring under 5,
  #with the count of movies scoring under 5 aliased as bad_movies,
  #in descending order
  # hint: use 'select', 'where', 'group', 'order'

  #bizarre reason: bad_movies does not show up on pry.
  # Entirely relies on looking at table relations to pass specs!!!
  # take from movie - yr, COUNT(*) -> score < 5 ->
  # in order to resolve group by...

  #  has to be left in the table.
  #  must appear in the GROUP BY clause or be used in an aggregate function.
  #  cannot be bad_movies Alias.

  # so group('yr') fits these conditions.
   Movie
     .select('yr','COUNT(*) AS bad_movies')
     .where('score < 5')
     .group('yr')
     .order('bad_movies DESC')
end

def alphabetized_actors
  # display the first 10 actor names ordered from A-Z
  # hint: use 'order' and 'limit'

  Actor.select(:id, :name).order(:name).limit(10)
  # #ALT ANS:
  # Actor
  #   .order('name ASC')
  #   .limit(10)
end

def pulp_fiction_actors
  # practice using joins
  # display the id and name of all actors in the movie Pulp Fiction
  # hint: use 'select', 'joins', 'where'

  # FINAL ANS.
  # 12.1.4 Specifying Conditions on the Joined Tables
  # You can specify conditions on the joined tables using
  # the regular Array and String conditions.
  # Hash conditions provide a special syntax
  # for specifying conditions for the joined tables:

  #ex.
  # time_range = (Time.now.midnight - 1.day)..Time.now.midnight
  # Client.joins(:orders).where(orders: { created_at: time_range })
  Actor
      .select(:id, :name)
      .joins(:movies)
      .where(:movies => {title: 'Pulp Fiction'})
end

def uma_movies
  #practice using joins
  # display the id, title, and year of movies Uma Thurman has acted in
  # order them by ascending year
  # hint: use 'select', 'joins', 'where', and 'order'


  Movie
    .select(:id, :title, :yr)
    .joins(:actors)
    .where(:actors => {name: 'Uma Thurman'} )
    .order(:yr)

# ALT ANS:
  #   Movie
    # .select(:id, :title, :yr)
    # .joins(:actors)
    # .where('name = \'Uma Thurman\'')
    # .order('yr ASC')

    # You can just supply the raw SQL specifying the JOIN clause to joins:
    #
    # Author
    # .joins("INNER JOIN posts ON
    # posts.author_id = authors.id AND posts.published = 't'")

    # Category.joins(:articles).distinct. for non-dups from each
    #table.
end
