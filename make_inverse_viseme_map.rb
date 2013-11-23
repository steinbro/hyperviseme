#!/usr/bin/env ruby

require 'pstore'

class Hash
  def invert_with_duplicates
    new = {}
    self.each do |k,v|
      new[v] ||= []
      new[v].push(k)
    end
    new
  end
end

v = PStore.new("visemes.pstore")
v.transaction(true){ $visemes = v[:visemes] }

#$visemes.each{|w,vs| $visemes[w] = vs.join(" ") }

inverse = $visemes.invert_with_duplicates #.sort_by{|v,ws| ws.length }.reverse[0..9].inspect

i = PStore.new("inverse.pstore")
i.transaction{ i[:inverse] = inverse }
