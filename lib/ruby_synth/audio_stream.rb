module RubySynth
  class AudioStream < FFI::PortAudio::Stream
    include FFI::PortAudio

    attr_accessor :gain, :synth, :srate
    
    def initialize(gen, frameSize=2**9, gain=1.0, srate=44100)
      @synth = gen # responds to ticks
      @gain = gain
      @srate = srate
      raise ArgumentError, "#{synth.class} doesn't respond to ticks!" unless @synth.respond_to?(:ticks)
      init!(frameSize)
      start
    end

    def process(input, output, framesPerBuffer, timeInfo, statusFlags, userData)
      # inp = input.read_array_of_int16(framesPerBuffer)
      out = @synth.ticks(framesPerBuffer).map{ |x| x * @gain }
      output.write_array_of_float(out)
      :paContinue
    end

    def init!(frameSize=nil)
      API.Pa_Initialize

      # input = API::PaStreamParameters.new
      # input[:device] = API.Pa_GetDefaultInputDevice
      # input[:sampleFormat] = API::Float32
      # input[:suggestedLatency] = API.Pa_GetDeviceInfo( input[:device ])[:defaultLowInputLatency]
      # input[:hostApiSpecificStreamInfo] = nil
      # input[:channelCount] = 1 #2; 

      input = nil
      
      output = API::PaStreamParameters.new
      output[:device] = API.Pa_GetDefaultOutputDevice
      output[:suggestedLatency] = API.Pa_GetDeviceInfo(output[:device])[:defaultHighOutputLatency]
      output[:hostApiSpecificStreamInfo] = nil
      output[:channelCount] = 1
      output[:sampleFormat] = API::Float32
      open(input, output, srate, frameSize)

      at_exit do
        puts "#{self.class} terminating!"
        close
        puts " closing PortAudio stream..."
        API.Pa_Terminate
        puts "done!"
      end
    end  
  end
end
