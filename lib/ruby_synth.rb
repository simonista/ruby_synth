module Math
  TAU = PI * 2
  HALF_TAU = TAU / 2
  QUARTER_TAU = TAU / 4
  THREE_QUARTER_TAU = TAU * 3 / 4
end

require "ffi-portaudio"

module RubySynth
  require "ruby_synth/audio_stream"
  require "ruby_synth/version"
end
