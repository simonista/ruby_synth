module RubySynth
  class Additive < Generator
    attr_accessor :generators
    def initialize(generators)
      @generators = generators
    end

    def update
      generators.each{|g| g.sample_rate = sample_rate}
      @updated = true
    end

    def ticks(samples)
      update unless @updated
      sampled = generators.map{ |g| g.ticks(samples) }
      return sampled.first if sampled.length == 1
      f = sampled.shift
      f.zip(*sampled).map{ |vals| vals.inject(:+) }
    end
  end
end
