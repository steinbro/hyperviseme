A "viseme" is a visual phoneme, the visual rather than aural information
conveyed when speaking -- in simple terms, lip reading. While there are about
forty phonemes in the English language, there are only about a dozen visemes
distinguishable by the average viewer-listener, making "homovisemes" (words
with the same lip-reading appearance) far more common than homophones.
Animators have known this for decades, only needing to illustrate a handful of
mouth shapes to make dialogue look plausible on cartoon characters.

Exploiting the quantity of homovisemes for humor has gained popularity recently
in creations like [Bad Lip Reading](http://www.badlipreading.com).

The Carnegie Mellon Pronouncing Dictionary provides a word-to-phoneme mapping.
Combining this with a phoneme-to-viseme mapping from Lee and Yook ("Audio-to-
Visual Conversion Using Hidden Markov Models," 2002), we can generate a word-
to-viseme mapping. We then invert this mapping to get a homoviseme list.

Give it a try:

    make hyperviseme phrase="crazy"

Some nice examples:

* yale college -> hancock itch
* the look of love -> tycoon of knife
* one more time -> wine boredom
*  time to check out -> subdue jackass


BSD licensed. 

---
Daniel W. Steinbrook <dsteinbrook@gmail.com>
