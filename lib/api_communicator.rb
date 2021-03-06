require 'rest-client'
require 'json'
require 'pry'
require_relative 'command_line_interface.rb'


def get_character_movies_from_api(character_name)
  #make the web request
  response_hash = get_response_hash("http://swapi.dev/api/people")

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  character_hash = response_hash["results"].find {|character| character["name"].downcase == character_name}
  if character_hash.nil?
    puts "Misspelled something, you did. Try again, you may"
    character_name = get_character_from_user
    get_character_movies_from_api(character_name)
  else
    api_urls = character_hash["films"]
    api_urls.map do |url|
      get_response_hash(url)
    end
  end
    
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def get_response_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end



def print_movies(films)
  films.each do |film|
    puts film["title"]
    puts "*************"
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
  run_search
end

def run_search
  character = get_character_from_user
  show_character_movies(character)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
