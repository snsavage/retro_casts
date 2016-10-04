require "nokogiri"
require "open-uri"

require "retro_casts/version"
require "retro_casts/rails_casts"
require "retro_casts/episode"
require "retro_casts/website"
require "retro_casts/null_website"
require "retro_casts/CLI"

module RetroCasts
  def self.start
    puts ARGV.first
    loop do
      CLI.welcome
      episodes = RetroCasts::RailsCasts.new.episodes
      CLI.display_episode_list(episodes)
      puts "Please select an episode to view: "
      print ">"
      input gets.chomp
      if input == "exit"
        break
      end
    end
  end
end
