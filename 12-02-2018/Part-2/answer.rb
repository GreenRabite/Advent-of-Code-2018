file = File.open("./inputs.txt")
id_arr = []
file.each do |id|
  id_arr << id
end
def check_id(id1,id2)
  i = 0
  counter = 0
  while i < id1.length
    counter+=1 if id1[i] == id2[i]
    i+=1
  end
  counter == id1.length-1 ? true : false 
end

def find_phrase(x,y)
  answer = ""
  x.length.times do |i|
    answer << x[i] if x[i] == y[i]
  end
  puts "The id is #{answer}"
end

i=0
while i < id_arr.length
  x = i + 1
  while x < id_arr.length
    if check_id(id_arr[i],id_arr[x])
      puts "The first id is #{id_arr[i]} and the second is #{id_arr[x]}"
      find_phrase(id_arr[i],id_arr[x])
      return
    end
    x+=1
  end
  i+=1
end