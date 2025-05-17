# [What's wrong with NIST SP 800-90B](https://crypto.stackexchange.com/questions/83882/whats-wrong-with-nist-sp-800-90b)



[NIST SP 800-90B](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-90B.pdf) offers various tests for estimating entropy.  They also offer [an implementation](https://github.com/usnistgov/SP800-90B_EntropyAssessment) of these tests.  With their program called `ea_iid`, estimating entropy is very easy.

```
$ ea_iid random.dat
Calculating baseline statistics...
H_original: 7.884314
H_bitstring: 0.998545
min(H_original, 8 X H_bitstring): 7.884314

** Passed chi square tests

** Passed length of longest repeated substring test

Beginning initial tests...
Beginning permutation tests... these may take some time
** Passed IID permutation tests
```

So the min-entropy estimation for the source that produced random.dat is 7.88 bits of information per byte.

However, [this page](http://www.reallyreallyrandom.com/photonic/technical/90b/) calls it USELESS. I'm unable to reproduce the claims made this page --- none of my NIST SP 800-90B programs show even similar output as those  displayed by this page.  The output above is an example.  Am I running a totally different version of the programs?



As the author of that page I feel that some clarification is necessary:-

> Am I running a totally different version of the programs?

Yes. You're running the [IID](https://en.wikipedia.org/wiki/Independent_and_identically_distributed_random_variables) test. You need to run `ea_non_iid`.  What you've run assumes that the data sample is IID within a p=0.01  certainty.  It then calculates the min. entropy of the dataset using the maximum probability (*H*∞

). That's easy.

`ea_non_iid` attempts to measure *H*∞

 of correlated data.  That's hard. The reason 90B is pretty useless (and never used) is that code assumes  uniformly distributed data.  Well to be honest, no one really knows what the authors were thinking. [Insert appropriate conspiracy theory, but I draw your attention to Federal Information Security Modernization Act  (FISMA) of 2014, 44 U.S.C. § 3551 et seq., which is referenced on page 3 of 90B].



Other than a few laboratory binary entropy sources, most generate  some form of non uniform distribution.  You can get really weird ones  depending on how the source is sampled and packed into bytes. That site  has examples, and this is another one from a current project's source:-

[![histogram](https://i.sstatic.net/XvTcb.png)](https://i.sstatic.net/XvTcb.png)

The site also says to not trust anything on that site.    Do your own research and have a look at:-

*John Kelsey, Kerry A. McKay and Meltem Sönmez Turan, Predictive  Models for Min-Entropy Estimation, and Joseph D. Hart, Yuta Terashima,  Atsushi Uchida, Gerald B. Baumgartner, Thomas E. Murphy and Rajarshi  Roy, Recommendations and illustrations for the evaluation of photonic  random number generators.*

This is an extract:-

[![graph](https://i.sstatic.net/k0KHY.png)](https://i.sstatic.net/k0KHY.png)

You can see that in some cases *H*∞

 is underestimated sixfold.  Their various predictors are not very good. From experience and research I trust the LZ78Y compression predictor  the most, but still.  This is consistent with my own testing as shown.

John Kelsey is one of the 90B authors and so he criticises himself!