module RetroCasts
  class Website

    attr_reader :site_cache

    def initialize(cache = {})
      @site_cache = cache
    end

    def get_list(url, filter)
      if site_cache.has_key?(url)
        site_cache[url]
      else
        site = open_url(url)
        page = css(site, filter)
        add_to_cache(url, page)
        page
      end
    end

    private
    def add_to_cache(url, page)
      site_cache[url] = page
    end

    def open_url(url)
      begin
        open(url)
      rescue Errno::ENOENT
        NullWebsite.new
      end
    end

    def css(site, filter)
      begin
        Nokogiri::HTML(site).css(filter)
      rescue Nokogiri::CSS::SyntaxError
        NullWebsite.new
      end
    end
  end
end

