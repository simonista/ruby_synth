module RubySynth
  class Sawtooth < Angular
    def tick(angle)
      res = angle / Math::PI
      res -= 2 if res > 1
      res
    end
  end
end
