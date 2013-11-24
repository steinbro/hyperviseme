#!/usr/bin/env ruby

require 'pstore'

v = PStore.new("visemes.pstore")
v.transaction(true){ $visemes = v[:visemes] }

v = PStore.new("inverse.pstore")
v.transaction(true){ $inverse = v[:inverse] }

# Find shortest set of visemes at the beginning of the array that resembles a
# word
def find_shortest_prefix(visemes, min_length=0)
  buffer = visemes[0..min_length]
  while not $inverse.has_key?(buffer)
    if buffer.length < visemes.length
      buffer = visemes[0..buffer.length]
    else
      return nil
    end
	end
  return buffer.length
end

# Recursively find all possible ways to split the array of visemes into
# sub-arrays such that each sub-array resembles a word.
def find_possible_chunks(visemes, current=[])
  successes = []
  n = 0
  while n < visemes.length
    n = find_shortest_prefix(visemes, n)

    # no prefix looks like a word
    break if n.nil?

    # shortest prefix is entire list
    if n == visemes.length
      return successes + [current + [visemes[0...n]]]
    end

    # recurse over everything except this prefix
    successes += find_possible_chunks(visemes[n..-1], current + [visemes[0...n]])
  end
  return successes
end

# convert input argument to visemes
phrase = ARGV[0]
vises = phrase.downcase.gsub(/\.|,|\?|!/, "").split
              .map{|w| $visemes[w] }.flatten

puts phrase, vises.inspect

# larger chunks are potentially more interesting, so reverse to show them first
chunks = find_possible_chunks(vises).reverse

# display results
chunks.each do |chunkification|
  puts chunkification.inspect

  alternatives = chunkification.map{|visemes| $inverse[visemes] }
  alternatives.map{|a| a.length }.max.times do |row|
    puts '  ' + alternatives
               .map{|col| col[row].to_s.ljust(col.map{|x| x.length }.max) }
               .join('  ')
  end
  puts
end
