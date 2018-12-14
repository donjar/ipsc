def next_input
  loop do
    g = gets.chomp
    return g unless g.empty?
  end
end

def run
  cases = next_input.to_i
  loop do
    break if cases == 0

    n = next_input.to_i
    ks = next_input.split(' ').map(&:to_i)
    puts(ks.each_with_index.map do |k, idx|
      if idx < ks.length - 1
        10 ** (k.to_s.length - 1)
      else
        1
      end
    end.join(' '))

    cases -= 1
  end
end

run
