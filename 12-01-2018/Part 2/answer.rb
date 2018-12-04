file = File.open("./inputs.txt")
arr = []
frequency_shifting = file.map {|drift| drift.to_i}

frequency_counter = Hash.new(0)
i = 0
current_frequency = 0
while i < frequency_shifting.length
  frequency_counter[current_frequency.to_s] +=1
  if  frequency_counter[current_frequency.to_s] > 1
    puts "The resulting frequency is #{current_frequency}"
    break
  end
  current_frequency += frequency_shifting[i]
  i+=1
  i=0 if i == frequency_shifting.length
end