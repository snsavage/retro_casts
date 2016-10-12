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
    site ||= RetroCasts::RailsCasts.new

    loop do
      CLI.list_episodes(site.episodes)

      puts "*** #{message} ***" unless message == ""
      message = ""

      puts "Please select an option..."
      print ">"
      input = gets.chomp.split(" ")
      command = input.shift
      argument = input.join(" ")

      if integer?(command) && site.episode?(command.to_i)
        loop do
          episode = site.episode(command.to_i)
          CLI.show_episode_detail(episode)

          puts "Type 'exit' to go back or 'open' to open the episode in your browser."
          print ">"

          case gets.chomp.downcase
          when "exit"
            break
          when "open"
            `open #{site.host}/#{episode.link}`
          else
            puts "Please choose 'exit' or 'open'."
            print ">"
          end
        end
      elsif command == nil
        message = "Enter is not a valid selection."
      else
        case command.downcase
        when "search"
          puts "Searching for \"#{argument}\"..."
          site = RetroCasts::RailsCasts.new(search: argument)
        when "next"
          puts "Opening page #{site.page + 1}..."
          site = RetroCasts::RailsCasts.new(search: site.search,
                                            page: site.page + 1)
        when "back"
          puts "Opening page #{site.page - 1}..."
          site = RetroCasts::RailsCasts.new(search: site.search,
                                            page: site.page - 1)
        when "exit"
          break
        else
          message = "#{command} is not a valid selection."
        end
      end
    end
  end

  private
  def self.integer?(number)
    begin
      Integer(number)
      true
    rescue
      false
    end
  end
end
