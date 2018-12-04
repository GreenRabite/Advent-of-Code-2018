file = File.open("./inputs.txt")
frequency_calibration=0
file.each do |drift|
  frequency_calibration += drift.to_i
end

puts frequency_calibration

#406