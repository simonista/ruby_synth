module Math
  TWO_PI = 2 * PI
  PI_HALVES = PI / 2
  THREE_PI_HALVES = 3 * PI / 2
end

require "ffi-portaudio"

module RubySynth
  require "ruby_synth/audio_stream"
  require "ruby_synth/generators/generator"
  require "ruby_synth/generators/note"
  require "ruby_synth/generators/null_generator"
  require "ruby_synth/generators/arpeggio"
  require "ruby_synth/generators/angular"
  require "ruby_synth/generators/sine"
  require "ruby_synth/generators/square"
  require "ruby_synth/generators/sawtooth"
  require "ruby_synth/generators/triangle"
  require "ruby_synth/generators/additive"
  require "ruby_synth/version"
end
