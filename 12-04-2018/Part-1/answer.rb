def merge_sort(arr)
  return arr if arr.length <= 1
  mid_idx = arr.length/2
  left_arr = arr.take(mid_idx)
  right_arr = arr.drop(mid_idx)
  sort_left_arr = merge_sort(left_arr)
  sort_right_arr = merge_sort(right_arr)
  merge(sort_left_arr,sort_right_arr)
end

def merge(left,right)
  merged_array = []
  until left.empty? || right.empty?
    if left.first[:date] == right.first[:date]
      if left.first[:hour] == right.first[:hour]
        if left.first[:minute] < right.first[:minute]
          merged_array << left.shift
        else
          merged_array << right.shift
        end
      elsif left.first[:hour] < right.first[:hour]
        merged_array << left.shift
      else
        merged_array << right.shift
      end
    elsif left.first[:date] < right.first[:date]
      merged_array << left.shift
    else
      merged_array << right.shift
    end
  end
  merged_array + left + right
end

actions = []
file = File.open("./inputs.txt")
file.each do |action|
  date = action[1..10]
  hour=  action[12..13]
  minute=  action[15..16]
  event = action[18..-1]
  actions << {date:date, hour:hour, minute: minute, event:event}
end
# p actions.length
sorted_events = merge_sort(actions)
# p sorted_events.length
# puts sorted_events.map {|x| "Date:#{x[:date]} Hour:#{x[:hour]} Minute:#{x[:minute]} Event:#{x[:event]}" }
hash = Hash.new { |h,k| h[k] = Hash.new(0) }
guard_id = nil
start_time = nil
end_time = nil
sorted_events.each do |event|
  new_guard = event[:event].split(" ")[0].strip.chomp == "Guard" ? true : false
  if new_guard
    guard_id = event[:event].split(" ")[1].delete('#').to_i
  end
  if event[:event].strip.chomp == "falls asleep"
    start_time = event[:minute].to_i
  elsif event[:event].strip.chomp == "wakes up"
    end_time = event[:minute].to_i - 1
    # require 'pry'; binding.pry
    # p "#{start_time} #{end_time}"
    (start_time..end_time).each do |min|
      hash[guard_id.to_s][min.to_s]+=1
    end
    # p hash
    start_time = nil
    end_time = nil
  end
end

max = 0
id = 0
minute = 0
# p hash.keys
# p hash[2389]
# require 'pry'; binding.pry
hash.each do |k1,v1|
  v1.each do |k,v|
    if v >= max
      id = k1.to_i
      max = v
      minute = k.to_i
    end
  end
  # p k1
  # p v1.sort_by {|k,v| v}.reverse.take(1)
end

# p id
# p minute
p id * minute

# [2251, 3319, 1777, 3347, 103, 3371, 2389, 2137, 1889, 2129, 631, 2539, 2213, 439, 1319, 829, 1283, 2903, 1213, 241]