module RetroCasts
  class CLI
    def self.welcome
      puts "Welcome to RetroCasts!"
    end

    def self.list_episodes(episodes)
      episodes.each_with_index do |episode, i|
        display "#{i +1}. #{episode.title} - #{episode.date}"
      end
    end

    def self.show_episode_detail(episode)
      [:title, :number, :date, :length, :description, :link].each do |attribute|
        display("#{attribute.to_s.capitalize}: #{episode.send(attribute)}")
      end
    end

    def self.display(message = "")
      puts message
    end
  end
end

