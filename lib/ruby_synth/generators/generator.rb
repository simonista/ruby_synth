module RubySynth
  class Generator
    attr_accessor :sample_rate

    def ticks(samples)
      raise NotImplementedError
    end
  end
end
