cmudict:
	wget https://cmusphinx.svn.sourceforge.net/svnroot/cmusphinx/trunk/cmudict/cmudict.0.6d -O cmudict

visemes: cmudict
	./make_viseme_map.rb > visemes

visemes.pstore: visemes
	./make_viseme_pstore.rb

inverse.pstore: visemes.pstore
	./make_inverse_viseme_map.rb

hyperviseme: inverse.pstore visemes.pstore
	./hyperviseme.rb $(phrase)

clean:
	rm visemes *.pstore