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

  class NullWebsite
    def empty?
      true
    end
  end

  class Episode
    attr_accessor :title, :number, :date, :length, :link, :description
  end

  class RailsCasts
    attr_reader :url, :filter, :episodes

    def initialize(url = 'http://www.railscasts.com', filter = '.episode')
      @url = url
      @filter = filter

      nodeset = RetroCasts::Website.get_list(url, '.episode')
      @episodes = parse_episodes(nodeset)
    end

    private
    def parse_episodes(nodeset)
      @episdoes = nodeset.collect do |node|
        create_episode(node)
      end
    end

    def create_episode(node)
      episode = Episode.new
      episode.title = node.css(".main h2 a").text
      episode.number = node.css(".number").text
      episode.date = node.css(".published_at").text
      episode.length = node.css(".stats").text
      episode.link = node.css(".screenshot a").first.attributes["href"].value
      episode.description = node.css(".description").text
      return episode
    end
  end
end

