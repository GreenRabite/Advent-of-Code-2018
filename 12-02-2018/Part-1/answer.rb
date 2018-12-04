
def init
  file = File.open("./inputs.txt")
  checksum_inputs = Hash.new(0)
  file.each do |id|
    result = box_id_checker(id)
    result.values.uniq.each {|v| checksum_inputs[v.to_s]+=1}
  end
  puts checksum_inputs["2"] * checksum_inputs["3"]
end


def box_id_checker(id)
  hash= Hash.new(0)
  id.split("").each do |ch|
    hash[ch] += 1
  end
  hash.select {|k,v| v == 3 || v == 2}
end

init

#6723