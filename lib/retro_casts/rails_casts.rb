module RetroCasts
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
  end

  class RailsCasts
    HOST = 'http://www.railscasts.com/'
    NODE_SET_FILTER = '.episode'

    attr_reader :url, :page, :nodeset, :episodes

    def initialize(url)
      @url = url
      @page = get_page
      @nodeset = get_nodeset(page: page, filter: NODE_SET_FILTER)
      @episodes = []
    end

    private
    def get_page
      begin
        Nokogiri::HTML(open(url))
      rescue
        RetroCasts::NullNokogiri.new
      end
    end

    def get_nodeset(page: self.page, filter: NODE_SET_FILTER)
      nodeset = page.css(filter)
      if nodeset.empty?
        NullNokogiri.new
      else
        nodeset
      end
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
      episode.date = node.css(".pulished_at").text
      episode.length = node.css(".stats").text
      episode.link = node.css(".screenshot a").first.attributes["href"].value
      return episode
    end
  end
end

