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

    loop do
      display("#" * 50)
      site.list_episodes

      puts "*** #{message} ***" unless message == ""
      message = ""

      puts "Please select an option..."
      print ">"
      input = $stdin.gets.chomp.split(" ")
      command = input.shift
      argument = input.join(" ")

      if integer?(command) && site.episode?(command.to_i)
        loop do
          episode = site.episode(command.to_i)
          site.show_episode_detail(command.to_i)

          puts "Type 'exit' to go back or 'open' to open the episode in your browser."
          print ">"

          case $stdin.gets.chomp.downcase
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
        when "home"
          puts "Going back to the homepage..."
          site = site.get_search(nil)
        when "search"
          puts "Searching for \"#{argument}\"..."
          site = site.get_search(argument)
        when "next"
          puts "Opening page #{site.page + 1}..."
          site = site.next_page
        when "back"
          puts "Opening page #{site.page - 1}..."
          site = site.prev_page
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
