# encoding: utf-8

module Faker
  module String
    extend ModuleUtils
    extend self

    BACKSLASH = '\\'

    LOWERS     = k(('a'..'z').to_a)
    UPPERS     = k(('A'..'Z').to_a)
    LETTERS    = k(LOWERS + UPPERS)
    NUMBERS    = k(('0'..'9').to_a)
    WORD_CHARS = k(LETTERS + NUMBERS + ['_'])
    SPACES     = k([" ", "\t"])
    ESCAPEABLE_CHARS = '\\', '/', '.', '(', ')', '[', ']', '{', '}'

    def from_regexp(exp)
      result = ''
      @last_token = nil

      # Drop surrounding /'s and split into characters
      tokens = exp.inspect[1...-1].split(//)
      until tokens.empty?
        result << process_token(tokens)
      end

      result
    end

    private

    def join_escapes(tokens)
      result = []
      while tokens.any?
        token = tokens.shift
        token << tokens.shift if token == BACKSLASH
        result << token
      end
      result
    end

    def process_token(tokens)
      return '' if tokens.empty?

      token = tokens.shift

      case token
      when '?' then
        # TODO: Let ? generate nothong
        return '' # We already printed its target
      when '+' then
        tokens.unshift(token) if rand(2) == 1 # Leave the `+` on to run again
        return process_token(@last_token) # Run the last one at least once
      when '*' then
        tokens.unshift(token) if rand(2) == 1 # Leave the `*` on to run again
        return '' if rand(2) == 1 # Or maybe do nothing
        return process_token(@last_token) # Else run the last one again
      end

      generate_token token, tokens
    end

    def generate_token(token, tokens)
      case token
      when /\w/ then
        @last_token = [token]
        token
      when BACKSLASH then
        token = tokens.shift
        @last_token = ['\\', token]
        special(token)
      when '[' then
        set = []
        while (ch = tokens.shift) != ']'
          set << ch
        end
        @last_token = ['['] + set + [']']
        process_token([ArrayUtils.rand(join_escapes(set))])
      end
    end

    def special(token)
      case token
      when 'w' then WORD_CHARS.rand
      when 'd' then NUMBERS.rand
      when 's' then SPACES.rand
      when *ESCAPEABLE_CHARS then token
      end
    end
  end
end
