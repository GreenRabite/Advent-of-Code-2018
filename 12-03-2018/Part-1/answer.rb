
def init
  file = File.open("./inputs.txt")
  file.each do |input|
    (id, useless, distance, size ) = input.split(" ")
    id = id.delete('#').to_i
    (x_offset,y_offset) = distance.delete(':').split(",").map {|x| x.to_i}
    (x_size,y_size) = size.split("x").map {|x| x.to_i}
    place_patch_onto_quilt(x_offset, y_offset, x_size, y_size)
  end
  find_common_spot
end


def place_patch_onto_quilt(x_offset, y_offset, x_size, y_size)
  # puts "x_offset is #{x_offset}"
  # puts "y_offset is #{y_offset}"
  # puts "x_size is #{x_size}"
  # puts "y_size is #{y_size}"
  # puts '-------------------'
  1.upto(x_size) do |x|
    1.upto(y_size) do |y|
      $map[y_offset + y][x_offset + x] += 1
    end
  end
end

def find_common_spot
  # $map.each_with_index do |row,xidx|
  #   row.each_with_index do |column,yidx|
  #     $final_map[xidx][yidx] = 1 if $map[xidx][yidx] > 1
  #   end
  # end
  counter=0
  hash = Hash.new(0)
  $map.each do |row|
    row.each do |patch|
      counter+=1 if patch > 1
    end
  end
  puts '------------'
  p counter
end

def initTableMapping
  $map = Array.new(2000) { Array.new(2000,0) }
  $final_map = Array.new(2000) { Array.new(2000,0) }
  # $map = Array.new(5) { Array.new(5,0) }
  # $final_map = Array.new(5) { Array.new(5) }
end

initTableMapping
init
#103482





# # place_patch_onto_quilt(1,1,3,3)

# Plan = Struct.new(:id, :x, :y, :width, :height, keyword_init: true) do
#   def x_min; x + 1; end
#   def x_max; x_min + width; end
#   def y_min; y + 1; end
#   def y_max; y_min + height; end

#   def coords
#     @coords ||= (x_min...x_max).to_a.product (y_min...y_max).to_a
#   end
# end

# fabric = Hash.new(0)

# PARSER = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/
# plans = File.readlines('./input.txt').map do |input|
#   Plan.new(PARSER.match(input).named_captures.transform_values!(&:to_i)).tap do |plan|
#     plan.coords.each { |x, y| fabric[[x, y]] += 1 }
#   end
# end

# puts "Part 1: #{fabric.count { |_, v| v > 1 }}"

# puts "Part 2: #{plans.find { |p| p.coords.all? { |x, y| fabric[[x, y]] == 1 } }.id}"

# data = File.read('./inputs.txt').chomp.split("\n").map do |d|
#   d.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
# end
# # Part 1

# counts = Array.new(1000) { Array.new(1000, 0) }

# data.map(&:to_a).map { |a| a.map(&:to_i) }.each do |_, _, left, top, width, height|
#   (top..top + height - 1).each do |row|
#     (left..left + width - 1).each do |col|
#       counts[row][col] += 1
#     end
#   end
# end

# puts counts.flatten.count { |e| e >= 2}
# # Part 2

# counts = Array.new(1000) { Array.new(1000) }
# maps = []

# data.map(&:to_a).map { |a| a.map(&:to_i) }.each do |_, id, left, top, width, height|
#   maps << [id, left, top, width, height]
#   (top..top + height - 1).each do |row|
#     (left..left + width - 1).each do |col|
#       counts[row][col] = [] unless counts[row][col]
#       counts[row][col] << id
#     end
#   end
# end

# puts maps.find { |id, _, _, width, height| counts.flatten(1).count { |a| a == [id] } == width * height }[0]