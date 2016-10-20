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

      update
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
      @search = search_term
      update
    end

    def next_page
      @page += 1
      update
    end

    def prev_page
      if page > 1
        @page -= 1
        update
      else
        self
      end
    end

    def list_episodes
      episodes.each_with_index do |episode, i|
        RetroCasts.display "#{i +1}. #{episode.title} - #{episode.date}"
      end
    end

    def show_episode_detail(episode_number)
      current_episode = episode(episode_number)
      [:title, :number, :date, :length, :description, :link].each do |attribute|
        label = attribute.to_s.capitalize
        message = "#{label}: #{current_episode.send(attribute)}"
        RetroCasts.display(message)
      end
    end

    private
    def update
      @url = build_url
      @episodes = parse_episodes(website.get_list(url, filter))
    end

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
      Episode.new({
        title: node.css(".main h2 a").text,
        number: extract_integer(node.css(".number")),
        date: Date.parse(node.css(".published_at").text),
        length: extract_integer(node.css(".stats")),
        link: host + node.css(".screenshot a").first.attributes["href"].value,
        description: node.css(".description")
          .text.sub(/\(\d+ minutes\)/, '')
          .delete("\n").strip
      })
    end

    def extract_integer(data)
      data.text.match(/\d+/).to_s.to_i
    end
  end
end

