# Talkerton

Say things with `say` for OS X.

## Usage

    # Instantiate with something to say...
    Talkerton.new("Hello, World!").speak!
    
    # Or do it dynamically with a block
    talker = Talkerton.new
    talker.words { |val| "Hey, somebody called me #{val}." }
    talker.speak! 'a jerk'
    
    # You can use other voices
    Talkerton.new("Other voices too!", :voice => 'Robot').speak!
    
    # Call #voices to see a list of available options
    Talkerton.new.voices
    
## Simple Notifiers

    # Get alerted every minute
    talker = Talkerton.new('The minute has changed')
    talker.notify(:change) { Time.now.min }
    
    # Or do it like this
    talker = Talkerton.new('The minute has changed', :delay => 60)
    talker.notify(:when => true) { true }

I'm pretty tired, and this README sucks. I'll have to touch it up later.

(c) Copyright 2009 Pat Nakajima. All Rights Reserved. 
    