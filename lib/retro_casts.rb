require "nokogiri"
require "open-uri"

require_relative "./retro_casts/version"
require_relative "./retro_casts/rails_casts"
require_relative "./retro_casts/episode"
require_relative "./retro_casts/website"
require_relative "./retro_casts/null_website"
require_relative "./retro_casts/CLI"

require 'pry'

module RetroCasts
  extend CLI

  def self.start(klass: RetroCasts::RailsCasts)
    retro_welcome
    welcome

    if !ARGV.empty?
      site = klass.new(search: ARGV.join(" "))
    else
      site ||= klass.new
    end

    message = ""
    exit_all_loops = false

    loop do
      break if exit_all_loops

      display("#" * 50)
      site.list_episodes

      puts "*** #{message} ***" unless message == ""
      message = ""

      puts "Please select an option..."
      puts "Episodes: 1 to #{site.episodes.length}  | home | search {search terms} | next | back | exit"
      print ">"
      input = $stdin.gets.chomp.split(" ")
      command = input.shift
      argument = input.join(" ")

      if integer?(command) && site.episode?(command.to_i)
        loop do
          episode = site.episode(command.to_i)
          site.show_episode_detail(command.to_i)

          puts "Type 'back' to go back, 'open' to open the episode in your browser, or 'exit' to exit."
          print ">"

          case $stdin.gets.chomp.downcase
          when "exit"
            exit_all_loops = true
            break
          when "back"
            break
          when "open"
            `open #{episode.link}`
          else
            puts "Please choose 'back' or 'open'."
            print ">"
          end
        end
      elsif command == nil
        message = "Enter is not a valid selection."
      else
        case command.downcase
        when "home"
          puts "Going back to the homepage..."
          site.get_search(nil)
        when "search"
          puts "Searching for \"#{argument}\"..."
          site.get_search(argument)
        when "next"
          puts "Opening page #{site.page + 1}..."
          site.next_page
        when "back"
          puts "Opening page #{site.page - 1}..."
          site.prev_page
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
