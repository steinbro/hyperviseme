cmudict:
	wget https://raw.githubusercontent.com/cmusphinx/pocketsphinx/master/model/en-us/cmudict-en-us.dict -O cmudict

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
