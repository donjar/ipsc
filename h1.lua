total = 0

for i = 1, N do
  if i ~= myself then
    total = total + colors[i]
  end
end

total = (total % 4096)
total_tmp = total

if myself ~= 13 then
  my_digit = (total >> (myself - 1)) % 2
else
  my_digit = 0
  for i = 1, N do
    my_digit = (my_digit + total % 2) % 2
    total_tmp = total_tmp >> 2
  end
  print(my_digit)
end
hands = raise(my_digit == 1)

unknown_zero = 0
unknown_one = 0

for i = 1, (N - 1) do
  if i == myself then
    unknown_one = unknown_one + 2 ^ (i - 1)
  else
    his_number = colors[i]
    new_knowledge = (hands[i] and 1 or 0) * (2 ^ (i - 1))
    his_completed_hand_zero = (new_knowledge + (2 ^ (i - 1) + unknown_zero - (his_number % (2 ^ (i - 1)))) % (2 ^ (i - 1)) + 4096) % 4096
    his_completed_hand_one = (new_knowledge + (2 ^ (i - 1) + unknown_one - (his_number % (2 ^ (i - 1)))) % (2 ^ (i - 1)) + 4096) % 4096
    unknown_zero = (his_completed_hand_zero + his_number) % (2 ^ i)
    unknown_one = (his_completed_hand_one + his_number) % (2 ^ i)
  end
  print('unknown_zero', unknown_zero, 'unknown_one', unknown_one, 'his_completed_hand_zero', his_completed_hand_zero, 'his_completed_hand_one', his_completed_hand_one, 'new_knowledge', new_knowledge, 'his_number', his_number, 'i', i)
end

if myself == N then
  sigma = unknown_zero
else
  total_digit_zero = 0
  uz_temp = unknown_zero - colors[N]
  for i = 1, N do
    total_digit_zero = (total_digit_zero + uz_temp % 2) % 2
    uz_temp = uz_temp >> 2
  end
  if total_digit_zero == (hands[N] and 1 or 0) then
    sigma = unknown_zero
  else
    sigma = unknown_one
  end
end

answer = (sigma - total + 4096 + 4096 - 1) % 4096 + 1
print('sigma', sigma, 'unknown_zero', unknown_zero, 'unknown_one', unknown_one, 'myself', myself, 'answer', answer)
