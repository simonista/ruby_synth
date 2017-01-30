module RubySynth
  class Square < Angular
    def tick(angle)
      angle < Math::PI ? 1.0 : -1.0
    end
  end
end
