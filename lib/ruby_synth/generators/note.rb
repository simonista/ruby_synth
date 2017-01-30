module RubySynth
  class Note < Generator
    attr_accessor :gen, :start, :envelope
    def initialize(gen)
      @gen = gen
      @start = Time.now.to_f
      @envelope = 0.5
    end
   
    def frequency=(arg)
      gen.frequency = arg
      @start = Time.now.to_f
      @envelope = 0.5
    end

    def sample_rate=(arg)
      super
      gen.sample_rate = arg
    end

    def update
      curr = Time.now.to_f
      if (curr - start) < 0.1
        @envelope = [envelope + 0.1, 1.0].min
      elsif (curr - start) < 0.2
        @envelope = [envelope - 0.05, 0.7].max
      end
    end
   
    def ticks(samples)
      update
      gen.ticks(samples).map{|x| x * envelope}
    end
  end
end
