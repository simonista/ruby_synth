module RubySynth
  class Arpeggio < Generator
    attr_accessor :gen, :start, :envelope
    def initialize(gen)
      @gen = gen
      @start = Time.now.to_f
      @inc = 1.05946309 # ~ 12th root of two
      @pattern = [4, 3, 5]
      @cycle = 0
    end
   
    def frequency=(arg)
      gen.frequency = arg
      @start = Time.now.to_f
      @cycle = 0
    end

    def frequency
      gen.frequency
    end

    def sample_rate=(arg)
      super
      gen.sample_rate = arg
    end

    def update
      curr = Time.now.to_f
      if (curr - start) > 0.1 * (@cycle + 1) && @cycle < 10
        new_freq = frequency
        @pattern[@cycle % @pattern.length].times { new_freq *= @inc }
        gen.frequency = new_freq
        @cycle += 1
      end
    end
   
    def ticks(samples)
      update
      gen.ticks(samples)
    end
  end
end
