module RubySynth
  class Angular < Generator
    attr_accessor :frequency
    def initialize(frequency: 440)
      self.frequency = frequency
      @angle = 0
    end
   
    def frequency=(arg)
      @frequency = arg
      @angle_rate = nil
      @angle = 0
    end

    def angle_rate
      @angle_rate ||= Math::TWO_PI * frequency / sample_rate
    end
   
    def update
      @angle += angle_rate
      @angle -= Math::TWO_PI if @angle > Math::TWO_PI
    end
   
    def ticks(samples)
      samples.times.map{ update; tick(@angle) }
    end
  end
end
