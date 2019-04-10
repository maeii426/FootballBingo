# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /^the admin page$/ then '/admin/'
    when /^the score board page$/ then '/score_board'
    when /^the help page$/ then '/help'
    when /^the log in page$/ then '/login'
    when /^the sign up page$/ then '/signup'
    when /^the home page$/ then '/#home'
    when /^the share page$/ then '/share'
    when /^the game play page$/ then '/game_play'
    when /^the profile page for "(.*)"$/
      user_id = User.find_by(name: $1).id
      user_path(user_id)
    when /^the edit page for "(.*)"$/ 
      user_id = User.find_by(name: $1).id
      edit_user_path(user_id)

    # when /^the edit page for "(.*)"$/
    #     movie_id = Movie.find_by(title: $1).id
    #     edit_movie_path(movie_id)
    when /^the details page for "(.*)"$/  
        movie = Movie.find_by(title: $1)
        movie_path(movie)
    when /^the Similar Movies page for "(.*)"$/    
        search_same_director_path($1)

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
