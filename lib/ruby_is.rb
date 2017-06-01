require "ruby_is/version"

module RubyIs
  class <<self
    def proc_or_block(args, block)
      case
      when args.empty?       && block      then block
      when (args.count == 1) && block.nil? then args.first
      else
        raise "Incorrect syntax for `is` statement"
      end
    end

    def block(&b); b; end

    def cache; @@cache ||= {}; end

    def eval_memoized(f, args, proc)
      cache = RubyIs.cache
      cache_key = [f, args, proc]
      if cache.has_key?(cache_key)
        cache[cache_key]
      else
        cache[cache_key] = f.call(*args, &proc)
      end
    end

    def eval_time_cached(f, caching_time, args, proc)
      cache = RubyIs.cache
      cache_key = [f, args, proc]
      if cache.has_key?(cache_key)
        last_call_time, value = cache[cache_key]
        return value if (Time.now - last_call_time) < caching_time
      end
      value = f.call(*args, &proc)
      cache[cache_key] = [Time.now, value]
      value
    end

    def with_memo(f, caching_time=nil)
      ->(*args, &proc){
        if caching_time
          RubyIs.eval_time_cached(f, caching_time, args, proc)
        else
          RubyIs.eval_memoized(f, args, proc)
        end
      }
    end
  end
end

module ::Kernel
  def is(*args, &block);
    { __is__method_body: RubyIs.proc_or_block(args, block) }
  end

  alias are is

  def method_missing(name, *args, &block)
    if (args.count == 1) and args.first.is_a?(Hash) and args.first.has_key?(:__is__method_body)
      define_method name, args.first[:__is__method_body]
      # at toplevel def creates private methods on Object
      if TOPLEVEL_BINDING.eval('self') == self # We are in the context of 'main' object
        private name
      end
    else
      super
    end
  end

  memoized is ->(*args, &block){
    RubyIs.with_memo RubyIs.proc_or_block(args, block)
  }

  cached is ->(caching_time, *args, &block){
    RubyIs.with_memo RubyIs.proc_or_block(args, block), caching_time
  }

  alias always memoized
end
