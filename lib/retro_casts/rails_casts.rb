module RetroCasts
  module Website
    def self.get_list(url:, filter:)
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

  class NullNokogiri
    def empty?
      true
    end

    def css(*)
      []
    end

    def collect
      NullNokogiri.new
    end
  end

  class RailsCasts
    HOST = 'http://www.railscasts.com/'
    NODE_SET_FILTER = '.episode'

    attr_reader :url, :page, :nodeset, :episodes

    def initialize(url)
      @url = url
      @page = get_page
      @nodeset = get_nodeset(page: page, filter: NODE_SET_FILTER)
      @episodes = parse_episodes
    end

    private
    def get_page
      begin
        Nokogiri::HTML(open(url))
      rescue Errno::ENOENT
        RetroCasts::NullNokogiri.new
      end
    end

    def get_nodeset(page: self.page, filter: NODE_SET_FILTER)
      nodeset = page.css(filter)
      # if nodeset.empty?
      #   NullNokogiri.new
      # else
      #   nodeset
      # end
    end

    def parse_episodes
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

