module RetroCasts
  class RailsCasts
    HOST = 'http://www.railscasts.com/'

    def self.get_page(url)
      begin
        Nokogiri::HTML(open(url))
      rescue
        nil
      end
    end

    # def self.get_nodeset(page, filter)
    #   page.css(filter)
    # end
  end

  class NullDocument
  end
end

