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

    def self.get_episode(list_number, episodes)
      index = list_number - 1

      if index >=0 && index < episodes.length
        episodes[index]
      else
        display("Invalid selection, please choose a number " +
                "between 1 and #{episodes.length}.")
      end
    end

    def self.valid_episode_number(input, length)
      begin
        Integer(input)
        if input.to_i.between?(1, length)
          input.to_i - 1
        else
          false
        end
      rescue
        false
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

