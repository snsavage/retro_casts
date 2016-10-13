module RetroCasts
  class CLI
    def self.welcome
      puts "Welcome to RetroCasts!"
    end

    def self.display(message = "")
      puts message
    end

    def self.retro_welcome
      retro_welcome = <<-ASCII
 _____      _              _____          _
|  __ \\    | |            / ____|        | |
| |__) |___| |_ _ __ ___ | |     __ _ ___| |_ ___
|  _  // _ \\ __| '__/ _ \\| |    / _` / __| __/ __|
| | \\ \\  __/ |_| | | (_) | |___| (_| \\__ \\ |_\\__ \\
|_|  \\_\\___|\\__|_|  \\___/ \\_____\\__,_|___/\\__|___/
    ASCII
      puts retro_welcome
    end
  end
end

