module RubySynth
  class NullGenerator
    def frequency; 0; end

    def ticks(samples)
      Array.new(samples, 0)
    end
  end
end
