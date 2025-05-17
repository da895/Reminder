# [Why are there different statistics tests in NIST SP 800-90B and NIST SP 800-22](https://stats.stackexchange.com/questions/366482/why-are-there-different-statistics-tests-in-nist-sp-800-90b-and-nist-sp-800-22)





Publication NIST SP 800-22 is a Standard, the NIST SP 800-90B **recommendation** ***might*** **someday** replace the current standard **after** it is ratified.

------

Sources for answer:

NIST SP 800-22: "[A Statistical Test Suite for Random and Pseudorandom Number Generators for Cryptographic Applications](https://www.nist.gov/publications/statistical-test-suite-random-and-pseudorandom-number-generators-cryptographic)", **Published**: September 16, 2010

> **Abstract**
>  This paper discusses some aspects of selecting and testing random and  pseudorandom number generators. The outputs of such generators ***may be used*** in many cryptographic applications, such as the generation of key  material. Generators suitable for use in cryptographic applications may  need to meet stronger requirements than for other applications. ...
>  [Supersedes SP 800-22 (May 15, 2001): http://www.nist.gov/manuscript-publication-search.cfm?pub_id=151222 ].

News Release: "[NIST is Proud to Announce the Release of 2 **DRAFT** Publications](https://csrc.nist.gov/News/2012/NIST-is-Proud-to-Announce-the-Release-of-2-DRAFT-P)" (September 05, 2012):

> NIST **requests comments** on two **Draft** publications for random bit generation: **Draft SP 800-90B**, Recommendation for the Entropy Sources Used for Random Bit Generation  and Draft SP 800-90C, Recommendation for Random Bit Generator (RBG)  Constructions.

News Release: "[NIST **Requests Comments** on Computer Security Publication on Randomness](https://www.nist.gov/news-events/news/2016/01/nist-requests-comments-computer-security-publication-randomness)" (January 27, **2016**):

> The **Second Draft** of Special Publication (SP) **800-90B**, Recommendation for the Entropy Sources Used for Random Bit Generation,  aims to help security specialists judge whether the source of random  numbers they use as part of the data encryption process is sufficiently  unpredictable. NIST is requesting public comments by May 9, 2016, on the draft document, which is available at NIST's CSRC website.

Series 800-90 Documents: "[Random Bit Generation](https://csrc.nist.gov/Projects/Random-Bit-Generation)":

> **Project Overview**
>
> The following publications specify the design and implementation of  random bit generators (RBGs), in two classes: Deterministic Random Bit  Generators (pseudo RBGs); and Non-Deterministic Random bit Generators  (True RBGs).
>
> - SP 800-90A, Recommendation for Random Number Generation Using Deterministic Random Bit Generators
>
> > June 25, 2015:  This Recommendation specifies mechanisms for the  generation of random bits using deterministic methods. In this revision, the specification of the Dual_EC_DRBG has been removed. The remaining  DRBGs (i.e., Hash_DRBG, HMAC_DRBG and CTR_DRBG) are recommended for use. Other changes included in this revision are listed in an appendix.
>
> - SP 800-90B, **Recommendation** for the Entropy Sources Used for Random Bit Generation
>
> > January 10, 2018:  This **Recommendation** specifies the design principles and requirements for the entropy sources used by  Random Bit Generators, and the tests for the validation of entropy  sources. These entropy sources are intended to be combined with  Deterministic Random Bit Generator mechanisms that are specified in SP  800-90A to construct Random Bit Generators, as specified in SP 800-90C.
>
> - SP 800-90C, Recommendation for Random Bit Generator (RBG) Constructions
>
> > April 13, 2016:  NIST invites comments on the second draft of NIST  Special Publication (SP) 800-90C, Recommendation for Random Bit  Generator (RBG) Constructions. This Recommendation specifies  constructions for the implementation of RBGs. An RBG may be a  deterministic random bit generator (DRBG) or a non-deterministic random  bit generator (NRBG). The constructed RBGs consist of DRBG mechanisms,  as specified in SP 800-90A, and entropy sources, as specified in SP  800-90B.  The comment period closed June 13, 2016
>
> On May 2-3, 2016, NIST hosted a workshop on Random Number Generation  to discuss the SP 800-90 series of documents--specifically, SP 800-90B  and SP 800-90C.