require 'rubygems'
require 'bacon'
require 'rr'

require File.join(File.dirname(__FILE__), *%w[.. lib talkerton])

describe Talkerton do
  extend RR::Adapters::TestUnit
  
  before do
    @talker = Talkerton.new('hello world')
  end

  it 'gets possible voices' do
    stub(@talker).exec('ls /System/Library/Speech/Voices').returns <<-LS
    Agnes.SpeechVoice
    Albert.SpeechVoice
    Alex.SpeechVoice
    LS
    @talker.voices.size.should.equal(3)
    @talker.voices.should.include('Albert')
    @talker.voices.should.include('Alex')
    @talker.voices.should.include('Agnes')
  end
end