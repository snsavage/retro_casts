require "nokogiri"
require "open-uri"

require "retro_casts/version"
require "retro_casts/rails_casts"
require "retro_casts/episode"
require "retro_casts/website"
require "retro_casts/null_website"
require "retro_casts/CLI"

require 'pry'

module RetroCasts
  def self.start
    puts ARGV.first
    CLI.welcome
    list
  end

  def self.list(episodes = nil)
    loop do
      episodes ||= RetroCasts::RailsCasts.new.episodes
      CLI.list_episodes(episodes)

      puts "Please select an episode to view: "
      print ">"
      input = gets.chomp

      if CLI.valid_episode_number(input, episodes)
        CLI.show_episode_detail(episodes[input.to_i - 1])
        detail(episodes)
      elsif input == "exit"
        break
      end
    end
  end

  def self.detail(episodes)
    puts "Type back to return to list:"
    print ">"
    input = gets.chomp

    if input.downcase == "back"
      list(episodes)
    else
      detail(episodes)
    end
  end
end
