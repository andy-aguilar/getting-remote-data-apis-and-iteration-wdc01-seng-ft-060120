def welcome
  puts "A long time ago in a galaxy far, far away... "
  puts "A user was researching star wars!"
  # puts out a welcome message here!
end

def get_character_from_user
  puts "Put in a character name to see a list of the movies they appear in"
  character = gets.chomp().downcase
  return character
  # use gets to capture the user's input. This method should return that input, downcased.
end
