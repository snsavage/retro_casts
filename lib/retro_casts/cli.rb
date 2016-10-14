module RetroCasts
  module CLI
    def welcome
      puts "Welcome to RetroCasts!"
    end

    def display(message = "")
      puts word_wrap(message, line_width: 70)
    end

    def retro_welcome
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

    private
    # Source:
    # http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#method-i-word_wrap
    def word_wrap(text, line_width: 80, break_sequence: "\n")
      text.split("\n").collect! do |line|
        line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1#{break_sequence}").strip : line
      end * break_sequence
    end
  end
end

