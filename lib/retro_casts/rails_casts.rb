module RetroCasts
  class RailsCasts
    attr_reader :url, :filter, :episodes

    def initialize(url = 'http://www.railscasts.com', filter = '.episode')
      @url = url
      @filter = filter

      @current_url = url

      nodeset = RetroCasts::Website.get_list(url, filter)
      @episodes = parse_episodes(nodeset)
    end

    def episode?(number)
      number > 0 && number <= episodes.length
    end

    def episode(number)
      if episode?(number)
        episodes[number - 1]
      else
        nil
      end
    end

    def search(search_string)
      encoded_search_string = URI.encode_www_form(search: search_string)
      search_url = "#{url}/episodes?utf8=%E2%9C%93&#{encoded_search_string}"

      @current_url = search_url

      nodeset = RetroCasts::Website.get_list(search_url, filter)
      @episodes = parse_episodes(nodeset)
    end

    private
    def parse_episodes(nodeset)
      nodeset.collect do |node|
        create_episode(node)
      end
    end

    def create_episode(node)
      episode = Episode.new
      episode.title = title(node)
      episode.number = number(node)
      episode.date = date(node)
      episode.length = length(node)
      episode.link = link(node)
      episode.description = description(node)
      return episode
    end

    def title(node)
      node.css(".main h2 a").text
    end

    def number(node)
      text = node.css(".number").text
      text.match(/\d+/).to_s.to_i
    end

    def date(node)
      text = node.css(".published_at").text
      Date.parse(text)
    end

    def length(node)
      text = node.css(".stats").text
      text.match(/\d+/).to_s.to_i
    end

    def link(node)
      node.css(".screenshot a").first.attributes["href"].value
    end

    def description(node)
      text = node.css(".description").text
      text.sub(/\(\d+ minutes\)/, '').delete("\n").strip
    end
  end
end

