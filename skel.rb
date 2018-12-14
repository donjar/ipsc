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



    cases -= 1
  end
end

run
