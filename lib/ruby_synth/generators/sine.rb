module RubySynth
  class Sine < Angular
    def tick(angle)
      Math.sin(angle)
    end
  end
end
