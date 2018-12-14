require 'set'

$extended_gcd_memo = {}
def extended_gcd(a, b)
  memo = $extended_gcd_memo[[a, b]]
  if !memo.nil?
    return memo
  end

  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end

  $extended_gcd_memo[[a, b]] = [last_remainder, last_x * (a < 0 ? -1 : 1)]
end
 
def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'The maths are broken!'
  end
  x % et
end

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

    p, k, n = next_input.split(' ').map(&:to_i)

    s = Set.new()
    approx = 0
    n.times do
      a, b, m = next_input.split(' ').map(&:to_i)
      k_i = ((a * k + b) % p) % m
      approx += (p / m)
    end

    # puts s.length
    puts (approx / Math::E).to_i

    cases -= 1
  end
end

run
