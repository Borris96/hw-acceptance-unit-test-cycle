class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
    # Define an error
  class Movie::NoDirectorInformation < StandardError; end

  def self.find_same_director(id)
    movie = self.find(id)
    director = movie.respond_to?('director') ? movie.director : ''
    if director and !director.empty?
      # self.find_all_by_director(director)
      # Find the director name which matches the symbol :director, and then list all the movies by him.
      self.where(:director => director).sort{|a, b| director.index(a.director) <=> director.index(b.director)}
    else
      raise Movie::NoDirectorInformation
    end
  end
  
end
