module RubySynth
  class Triangle < Angular
    def tick(angle)
      if angle < Math::PI_HALVES
        angle / Math::PI_HALVES
      elsif angle < Math::THREE_PI_HALVES
        angle / -Math::PI_HALVES + 2
      else
        angle / Math::PI_HALVES - 4
      end
    end
  end
end
