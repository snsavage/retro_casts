module RetroCasts
  class Episode
    attr_accessor :title, :number, :date, :length, :link, :description
    
    def initialize(attributes = {})
      @title = attributes[:title]
      @number = attributes[:number]
      @date = attributes[:date]
      @length = attributes[:length]
      @link = attributes[:link]
      @description = attributes[:description]
    end

    def date
      @date.strftime("%b %-d, %Y")
    end

    def length
      "#{@length} minutes"
    end
  end
end

