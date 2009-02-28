require File.join(File.dirname(__FILE__), *%w[.. lib talkerton])

class Exemplar
  attr_accessor :waiting

  def ping!
    if self.waiting
      puts
      exit 0 
    end
    $PINGED = !$PINGED
    allow_exit
  end
  
  def count
    @count ||= 0
    @count += 1
  end

  def allow_exit
    puts
    print "Interrupt within 3 seconds to quit"
    self.waiting = true
    Thread.new do
      3.times { $stdout.print('.'); $stdout.flush; sleep 1 }
      self.waiting = false
      puts " canceled."
    end
  end
end

exemplar = Exemplar.new

Signal.trap('INT') do
  exemplar.ping!
end

t = Talkerton.new('Hello World!', :voice => 'Vicki')
t.words { |val| "new value: #{val.inspect}. The count is now #{exemplar.count}" }
t.notify(:change) { $PINGED }