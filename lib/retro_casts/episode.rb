module RetroCasts
  class Episode
    attr_accessor :title, :number, :date, :length, :link, :description

    def date
      @date.strftime("%b %-d, %Y")
    end

    def length
      "#{@length} minutes"
    end
  end
end

