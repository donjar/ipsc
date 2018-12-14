def next_input
  loop do
    g = gets.chomp
    return g unless g.empty?
  end
end

# x -> (2^x + 1) mod (10^9 + 7)
def calc(x)
  (2 ** x + 1) % (10 ** 9 + 7)
end

def advance(fold, e, se, s, sw, w, nw, n, ne, mid)
  case fold
  when 'L'
    [e, se, s * 2 + sw, se, e, ne, n * 2 + nw, ne, 2 * mid + w]
  when 'R'
    [w, sw, s * 2 + se, sw, w, nw, n * 2 + ne, nw, 2 * mid + e]
  when 'B'
    [e * 2 + se, ne, n, nw, 2 * w + sw, nw, n, ne, 2 * mid + s]
  when 'T'
    [e * 2 + ne, se, s, sw, 2 * w + nw, sw, s, se, 2 * mid + n]
  end
end

def run
  cases = next_input.to_i
  loop do
    break if cases == 0

    total_cuts = next_input.to_i
    if total_cuts == 0
      puts 1
      cases -= 1
      next
    end

    folds = next_input
    cut_dir = next_input

    if cut_dir == 'LR' || cut_dir == 'RL'
      puts (calc(folds.chars.map { |x| x == 'T' || x == 'B' ? 1 : 0 }.sum))
    elsif cut_dir == 'BT' || cut_dir == 'TB'
      puts (calc(folds.chars.map { |x| x == 'L' || x == 'R' ? 1 : 0 }.sum))
    else
      e = 0
      se = 0
      s = 0
      sw = 0
      w = 0
      nw = 0
      n = 0
      ne = 0
      mid = 0

      if ['LT', 'TL'].include?(cut_dir)
        nw += 1
      elsif ['RT', 'TR'].include?(cut_dir)
        ne += 1
      elsif ['RB', 'BR'].include?(cut_dir)
        se += 1
      elsif ['LB', 'BL'].include?(cut_dir)
        sw += 1
      end

      folds.reverse.chars.each do |fold|
        v = advance(fold, e, se, s, sw, w, nw, n, ne, mid)
        e, se, s, sw, w, nw, n, ne, mid = v
      end
      puts ((e + se + s + sw + w + nw + n + ne + mid + 1) % (10 ** 9 + 7))
    end

    cases -= 1
  end
end

run
