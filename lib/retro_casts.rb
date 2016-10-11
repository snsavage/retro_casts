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

    message = ""

    loop do
      site ||= RetroCasts::RailsCasts.new
      episodes ||= site.episodes
      CLI.list_episodes(episodes)

      puts "*** #{message} ***" unless message == ""
      message = ""

      puts "Please select an option..."
      input = gets.chomp

      if CLI.valid_episode_number(input, episodes)
        loop do
          CLI.show_episode_detail(episodes[input.to_i - 1])

          puts "Type 'exit' to go back or 'open' to open the episode in your browser."
          print ">"

          case gets.chomp.downcase
          when "exit"
            break
          when "open"
            `open #{site.url}/#{episodes[input.to_i - 1].link}`
          else
            puts "Please choose 'exit' or 'open'."
          end
        end
      else
        case input.downcase
        when "search"
          puts "Time to search."

        when "exit"
          break
        else
          message = "#{input} is not a valid selection."
        end
      end
    end
  end
end
