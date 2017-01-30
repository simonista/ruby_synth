module RubySynth
  class AudioStream < FFI::PortAudio::Stream
    include FFI::PortAudio

    attr_accessor :gain
    attr_reader :generator, :frame_size, :sample_rate
    
    def initialize(gain: 0.8, frame_size: 512, sample_rate: 44100)
      @gain = gain
      @frame_size = frame_size
      @sample_rate = sample_rate

      @null_gen = NullGenerator.new
      @generator = @null_gen

      init!
    end

    # expects an instance of Generator
    def load(generator)
      @generator = generator
      generator.sample_rate = sample_rate
    end

    def unload
      @generator = @null_gen
    end

    def process(input, output, frames_per_buffer, time_info, status_flag, user_data)
      # inp = input.read_array_of_int16(frames_per_buffer)
      out = generator.ticks(frames_per_buffer).map{ |x| x * gain }
      output.write_array_of_float(out)
      :paContinue
    end

    def init!
      API.Pa_Initialize

      open(input_params, output_params, sample_rate, frame_size)

      at_exit do
        print "#{self.class} terminating!... "
        close
        print "closing PortAudio stream... "
        API.Pa_Terminate
        puts "done!"
      end

      start
    end  

    def output_params
      output = API::PaStreamParameters.new
      output[:device] = API.Pa_GetDefaultOutputDevice
      output[:suggestedLatency] = API.Pa_GetDeviceInfo(output[:device])[:defaultHighOutputLatency]
      output[:hostApiSpecificStreamInfo] = nil
      output[:channelCount] = 1
      output[:sampleFormat] = API::Float32
      output
    end

    def input_params
      # input = API::PaStreamParameters.new
      # input[:device] = API.Pa_GetDefaultInputDevice
      # input[:sampleFormat] = API::Float32
      # input[:suggestedLatency] = API.Pa_GetDeviceInfo( input[:device ])[:defaultLowInputLatency]
      # input[:hostApiSpecificStreamInfo] = nil
      # input[:channelCount] = 1 #2; 

      nil
    end
  end
end
