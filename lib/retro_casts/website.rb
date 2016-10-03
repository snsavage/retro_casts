module RetroCasts
  module Website
    def self.get_list(url, filter)
      site = open_url(url)
      css(site, filter)
    end

    private
    def self.open_url(url)
      begin
        open(url)
      rescue Errno::ENOENT
        NullWebsite.new
      end
    end

    def self.css(site, filter)
      begin
        Nokogiri::HTML(site).css(filter)
      rescue Nokogiri::CSS::SyntaxError
        NullWebsite.new
      end
    end
  end
end

