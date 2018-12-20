Guard = Struct.new("Guard", :id, :total, :minutes)

guards = {}
guard = nil
asleep = nil

File.readlines("inputs.txt").sort.each { |l|

  if l =~ /Guard \#(\d+) begins shift$/
    id = $1.to_i
    guard = guards[id] ||= Guard.new(id, 0, [0] * 60)
  
  elsif / 00:(?<minute>\d+)\] falls asleep$/ =~ l
    asleep = minute.to_i 
  
  elsif l =~ / 00:(\d+)\] wakes up$/
  
    awake = $1.to_i
    
    guard.total += awake - asleep
    (asleep...awake).each { |min|
      guard.minutes[min] += 1
    }
    
  end
}

guard = (guards.values.sort_by {|g| g.total}).last
p guard.id
p guard.minutes.each_with_index.max[1]
puts "Part1: #{guard.id * guard.minutes.each_with_index.max[1]}"

guard = (guards.values.sort_by {|g| g.minutes.each_with_index.max[0] }).last
puts "Part2: #{guard.id * guard.minutes.each_with_index.max[1]}"