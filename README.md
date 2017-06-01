# RubyIs

Define small functions easier!

## Usage

    require 'ruby_is'

    ruby is { :awesome }
    ruby #=> :awesome

    rubies are {|how| "#{how} awesome"}
    rubies "totally" # => "totally awesome"

    inc is ->(a){ puts "calculating #{a}"; a+1 }
    inc 42 #=> "calculating 42"; 43

    inc_m is always {|a| inc a }
    # inc_m is memoized {|a| inc a } # this also works
    inc_m 42 #=> "calculating 42"; 43
    inc_m 42 #=> 43
    inc_m 10 #=> "calculating 10"; 11

    inc_m is cached(1) {|a| inc a }
    # inc_m is cached(1.second) {|a| inc a }  # if active_support/time have been enabled
    inc_m 42 #=> "calculating 42"; 43
    inc_m 42 #=> 43
    sleep 2
    inc_m 42 #=> "calculating 42"; 43

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_is'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_is

## Contributing

1. Fork it ( https://github.com/alesguzik/ruby_is/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
