module RetroCasts
  class NullWebsite
    def empty?
      true
    end

    def collect
      self
    end

    def each_with_index
      RetroCasts.display("No Episodes Found")
    end
  end
end

