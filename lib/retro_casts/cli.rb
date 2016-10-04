module RetroCasts
  class CLI
    def self.welcome
      puts "Welcome to RetroCasts!"
    end

    def self.episode_list(episodes)
      episodes.each_with_index do |episode, i|
        display "#{i +1}. #{episode.title} - #{episode.date}"
      end
    end

    def self.display(message = "")
      puts message
    end
  end
end

