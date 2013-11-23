#!/usr/bin/env ruby

require 'pstore'

v = PStore.new("visemes.pstore")
v.transaction(true){ $visemes = v[:visemes] }
v = PStore.new("inverse.pstore")
v.transaction(true){ $inverse = v[:inverse] }

class String
  #def to_phonemes
  #  self.split.map
  #end

  def to_visemes
    self.downcase.gsub(/\.|,|\?|!/, "").split.map{|w| $visemes[w] }.flatten
  end
end

class Array
  def sum
    self.inject(0) {|total, n| total + n }
  end

  def random_choice
    self[rand(self.length)]
  end

  def random_chunkify(max_length)
    sizes = []
    while sizes.sum < self.length
      nextsize = rand(max_length - 1) + 1
      if sizes.sum + nextsize <= self.length
        sizes.push(nextsize)
      end
    end
    i = 0
    sizes.map do |l|
      i += l
      self[i-l...i]
    end
  end
end

#puts vises.inspect
#0.upto(vises.length / 3) do |i|
#  subvise = vises[3*i...3*(i+1)]
#  matches = $inverse[subvise]
#  puts "#{subvise.inspect}: #{matches.inspect}"
#end

phrase = ARGV[0]
vises = phrase.to_visemes

i = vises.length < 20 ? vises.length : 20
sizes = []
j =  0
while j < vises.length
  while not $inverse.has_key?(vises[j...j+i])
    i -= 1
    if i == 0
      puts vises.inspect
      exit
    end
  end
  j += i
  sizes.push(i)
  i = vises.length  - j < 20 ? vises.length - j : 20
end

i = 0
chunks = sizes.map do |l|
  i += l
  vises[i-l...i]
end
#chunks = vises.random_chunkify(8)
alternatives = chunks.map{|vis| $inverse[vis]}

puts phrase, chunks.inspect
puts alternatives
