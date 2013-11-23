#!/usr/bin/env ruby

require 'pstore'

$visemes = {}
open("visemes").each_line do |line|
  word, vises = line.rstrip.split(" ", 2)
  $visemes[word] = vises.split.map{|v| v.to_sym }
end

v = PStore.new("visemes.pstore")
v.transaction { v[:visemes] = $visemes }
