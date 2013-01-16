require 'active_support/all'

class Pattern
  NAMES = {
    'holygrail' => %w[2.5p 3.5p 4.5p],
    'babydragon' => %w[4.5p 2.5p 1 1 1],
    'babydragontwins' => %w[4.5p 2.5p 4.5p 2.5p 1],
  }

  attr_reader :pattern
  def initialize(pattern)
    @source = pattern.dup
    if NAMES[pattern]
      @pattern = NAMES[pattern]
    else
      # TODO: Test the crap out of this, it looks like black magic
      @pattern = self.class.parse_pattern(pattern.dup)
    end
  end

  def self.parse_pattern(pattern)
    pattern = pattern.gsub(/[^\d\.p]/, ' ')
    array = pattern.split(/\s+|(?<=p)|((?<=\d)(?=\d))/)
    array.select(&:present?)
  end

  def period
    @pattern.length
  end

  def to_s
    @pattern.join(' ')
  end

  def to_param
    @pattern.join('%20')
  end

  def to_a
    @pattern
  end

  def inspect
    "#<Pattern #{to_s} source:#{@source}>"
  end
end


