
def init
  file = File.open("./inputs.txt")
  file.each do |input|
    (id, useless, distance, size ) = input.split(" ")
    id = id.delete('#').to_i
    (x_offset,y_offset) = distance.delete(':').split(",").map {|x| x.to_i}
    (x_size,y_size) = size.split("x").map {|x| x.to_i}
    place_patch_onto_quilt(x_offset, y_offset, x_size, y_size,id)
  end
  $map.length.times do |x|
    $map[0].length.times do |y|
      $final_map[y][x] = $map[y][x].split(",")
    end
  end
  p $final_map.select do |row|
    row.select {|x| x.length == 1}.flatten
  end.flatten
end


def place_patch_onto_quilt(x_offset, y_offset, x_size, y_size,id)
  1.upto(x_size) do |x|
    1.upto(y_size) do |y|
      $map[y_offset + y][x_offset + x] += "#{id},"
      # $hash[id.to_s] = $map[y_offset + y][x_offset + x].length if $map[y_offset + y][x_offset + x].length > $hash[id.to_s]
    end
  end
  # $hash
end

# def find_common_spot
#   counter=0
#   hash = Hash.new(0)
#   $map.each do |row|
#     row.each do |patch|
#       counter+=1 if patch > 1
#     end
#   end
#   puts '------------'
#   p counter
# end

def initTableMapping
  $map = Array.new(2000) { Array.new(2000,"") }
  $final_map = Array.new(2000) { Array.new(2000,"") }
  $hash = Hash.new(0)
end

initTableMapping
init