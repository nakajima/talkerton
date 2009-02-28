class Talkerton
  def self.voices
    new.voices
  end

  def initialize(*words)
    @words = words
    @options = @words.last.is_a?(Hash) ? @words.pop : {}
    opt(:voice, '-v')
    opt(:delay, '-d')
    opt(:script, '-s')
    opt(:help, '-h') do
      puts "Usage: talker [words]"
      puts "Voices: #{voices.join(', ')}"
      exit 0
    end
  end

  def speak!(*args)
    exec 'say %s %s' % [opts, words(*args)]
  end

  def notify(on, &block)
    loop do
      on.is_a?(Symbol) ? change(&block) : remain(&block)
      sleep (@options[:delay] || 1)
    end
  end

  def remain(&block)
    value = block.call
    speak!(value) if value
  end

  def change(&block)
    value = block.call
    speak!(value) if defined?(@changed) and @changed != value
    @changed = value
  end

  def words(*args, &block)
    if block_given?
      @words = block
    else
      @words.respond_to?(:call) ?
        @words.call(*args) :
        @words
    end
  end

  def opts
    if voice = @options[:voice]
      '-v %s' % voice
    end
  end

  def voices
    exec('ls /System/Library/Speech/Voices').scan(/([A-Za-z]+)\.SpeechVoice/).flatten
  end

  private

  def opt(name, *matchers)
    idx = (matchers << "--#{name}").inject(nil) { |res, m| res ||= @words.index(m) }
    return unless idx
    if block_given?
      yield
    else
      val = @words[idx+1]
      @words.delete(val)
      @words.delete(@words[idx])
      @options[name] = val
    end
  end

  def exec(cmd)
    `#{cmd}`
  end
end
