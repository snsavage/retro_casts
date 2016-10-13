module RetroCasts
  class RailsCasts
    attr_reader :host, :filter, :episodes, :page, :search, :url, :website

    def initialize(host: 'http://www.railscasts.com',
                   filter: '.episode',
                   page: 1,
                   search: nil,
                   website: RetroCasts::Website.new)

      @host = host
      @filter = filter
      @page = page
      @search = search
      @website = website

      @url = build_url

      nodeset = website.get_list(url, filter)
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

    def get_search(search_term)
      RetroCasts::RailsCasts.new(search: search_term, website: website)
    end

    def next_page
      RetroCasts::RailsCasts.new(search: search,
                                 page: page + 1,
                                 website: website)
    end

    def prev_page
      if page > 1
        RetroCasts::RailsCasts.new(search: search,
                                   page: page - 1,
                                   website: website)
      else
        self
      end
    end

    def list_episodes
      episodes.each_with_index do |episode, i|
        RetroCasts::CLI.display "#{i +1}. #{episode.title} - #{episode.date}"
      end
    end

    def show_episode_detail(episode_number)
      current_episode = episode(episode_number)
      [:title, :number, :date, :length, :description, :link].each do |attribute|
        label = attribute.to_s.capitalize
        message = "#{label}: #{current_episode.send(attribute)}"
        RetroCasts::CLI.display(message)
      end
    end

    private
    def build_url
      attributes = {}

      attributes[:search] = search if search
      attributes[:page] = page if page != 1

      if !attributes.empty?
        query = URI.encode_www_form(attributes)
      end

      if attributes.has_key?(:search)
        "#{host}\/episodes?#{query}"
      elsif attributes.has_key?(:page)
        "#{host}\/?#{query}"
      elsif host != ""
        "#{host}\/"
      else
        ""
      end
    end

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

