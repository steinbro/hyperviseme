#!/usr/bin/env ruby

dict = "cmudict"

# map from viseme to phonemes
vis2pho = {:p  => [:p, :b, :m, :em],
           :f  => [:f, :v],
           :t  => [:t, :d, :s, :z, :th, :dh, :dx],
           :w  => [:w, :wh, :r],
           :ch => [:ch, :jh, :sh, :zh],
           :ey => [:eh, :ey, :ae, :aw],
           :k  => [:k, :g, :n, :l, :nx, :hh, :y, :el, :en, :ng],
           :iy => [:iy, :ih],
           :aa => [:aa],
           :ah => [:ah, :ax, :ay],
           :er => [:er],
           :ao => [:ao, :oy, :ix, :ow],
           :uh => [:uh, :uw],
           :sp => [:sil, :sp]}

# map from phoneme to viseme
pho2vis = {}
vis2pho.each{|v,ps| ps.each{|p| pho2vis[p] = v } }

visdict  = {}
#homovisemes = {}
#phonedist = {}

open(dict).each_line do |line|
  next if line[0..1] == "##"
  next unless line.index("(").nil? # ignore alternate pronunciations

  word, pronunciation = line.downcase.rstrip.split(" ", 2)

  phones = pronunciation.gsub(/[0-9]+/,"").split
  vises = phones.map{|p| pho2vis[p.to_sym] }

  #homovisemes[vises.join(' ')] ||= []
  #homovisemes[vises.join(' ')].push(word)
  #phonedist[phones.length] ||= 0
  #phonedist[phones.length] += 1

  visdict[word] = vises
end
#homovisemes.sort_by{|v,ws| ws.length}.reverse[0..19].each{|v, ws| puts "#{v}: #{ws.length} (#{ws[0]}, ...)" }
#puts phonedist.inspect
puts visdict.map{|w,vs| "#{w} #{vs.join(" ")}" }
