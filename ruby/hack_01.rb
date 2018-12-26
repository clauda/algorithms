
class Subset
  attr_reader :results

  def initialize(max_value = 0, per_gap, pattern)
    @max_value = max_value
    @per_gap = per_gap
    @pattern = pattern

    @gap_size = pattern.size
    @range_values = 0..8
    @gaps_to_fill = 0
    @results = []
  end

  def fill_the_gap
    possibilities = []
    digits = @pattern.scan(/\d/)
    total_assigned = digits.map(&:to_i).sum
    total_missing = @max_value - total_assigned
  
    @gaps_to_fill = @gap_size - digits.size
  
    self.sum(total_missing)
    
    @results.each do |result|
      match = @pattern.gsub(/\?/) { |m| result.pop } 
      possibilities.push(match)
    end
  
    return possibilities.sort
  end

  def sum(target, partial = [])
    total = partial.inject(0, :+) # check if the partial sum is equals to target
    
    if partial.size == @gaps_to_fill
      if total == target && self.allowed_per_gap?(partial)
        @results.push(partial)
      end
      return 
    end

    (@range_values).each do |i|
      self.sum(target, partial + [i])
    end

  end

  protected

    def allowed_per_gap?(partial)
      partial.all? { |val| val <= @per_gap }
    end

end

# p Subset.new(56, 8, '???8???').fill_the_gap
# p Subset.new(3, 2, '??2??00').fill_the_gap
p Subset.new(24, 4, '08??840').fill_the_gap
p Subset.new(3, 1, '???????').fill_the_gap