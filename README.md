# Solitaire #
Solitaire Encryption with Dynamic Decks

<h4>ABOUT SOLITAIRE</h4>
<p>The Solitaire cryptographic algorithm was designed by Bruce Schneier to allow field agents to communicate securely without having to rely on electronics or having to carry incriminating tools, at the request of Neal Stephenson for use in his novel Cryptonomicon. It was designed to be a manual cryptosystem calculated with an ordinary deck of playing cards. In Cryptonomicon, this algorithm was originally called Pontifex to hide the fact that it involved playing cards.</p>

<h4>REQUIREMENTS</h4>
<p>A deck of Cards with Two Jokers</p>

<h4>THEORY</h4>
<p>A deck of cards provides us with 54! possible combinations of the arrangement of cards in the deck. Using one such deck combination, we move ahead with the KeyStream Generation, which is the heart of the Solitaire Cipher. When implemented with a PassPhrase then prior to generating KeyStream, the cards have to shuffled using the method described for PassPhrase Shuffle.</p>
<p>Since, Solitaire Cipher, is an output-feedback mode stream cipher, the KeyStream Generator will throw out One Card at the end of every KeyStream generation process, and this process is basically shuffling of cards based on the described method.</p>
<p>The reason for generating KeyStream is that for every character of the Plaintext ,a unique Keystream Character is generated and upon the completion of this entire process, the number associated with the alphabets of both the Plaintext and the KeyStream are added to generate a new number , and subsequently the character associated with this newly generated Number becomes the Solitaire Cipher Text.</p>
<p>Let us take a hypothetical example, wherein, a Random Combination of Deck is used which generates the below mentioned KeyStream.</p>

Plain Text | THISWORKS
:--- | :---: 
Key Stream | AJUTRNFHD
Cipher Text | URDMOGUSW

<p>In order to generate the cipher text, we shall rely on a table which associates the Alphabets to their corresponding number. Ie. A = 1 , B = 2 ….. Y = 25 , Z = 26</p>

<h4>IMPLEMENTATION</h4>
From a holistic point of view, the basic requirement for implementing this is that both the processes ie. Encryption and Decryption processes should be aware of the following 

* The Deck Combination Order.
* Passphrase , (If any)

However, when we have to implement this cipher for (non-sensitive) Digital Communications, the paradigm shifts drastically, as the information between the sender and the receiver can be intercepted and the cipher-message can be brute forced, especially when multiple messages with the same passphrase are generated.

The simple reason being, the deck combination never changes, as changing the deck combination would provide incorrect output after decryption. Moreover, the passphrase also needs to be known to both the parties / programs. It is also stated that after sending every message the pass-phrase needs to be changed so as to raise the level of difficulty for those who are intercepting the messages.

Due to this we now have two parameters, which are deemed crucial for a successful implementation, and have to be known to both the parties. 

In order to take advantage of Solitaire Cipher and its 54! Combinations, with the additional PassPhrase and reducing the overheads of sending the entire deck of cards to the recipient, we shall instead rely on associating ID Tags with a subset of deck combinations ie. 6! * 7! * 4! . 

This particular method would now be dependent on those who are implementing Solitaire Cipher. Moreover, the implementers may choose to randomize the associating tables in case of a breach.

It is also to be noted that, even though this method of Tag-IDs is not fool-proof however, it does provide an edge over the conventional implementation of Solitaire Cipher. 

<h4>DECK-ID GENERATION</h4>
As we all know, every deck has 13 cards belonging to 4 different suits. We begin by breaking up the 13 cards into two different sets of 6 cards and 7 cards and associating every card with a particular Alphabet. The implementer over here may choose their own set of cards to be a part of which group. 

______________________________________
Deck | A | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | J | Q | K
:--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---:
Reference | A | B | C | D | E | F | G | H | I | J | K | L | M
Index | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13
______________________________________

* First Set : ABCDEF
* Second Set: GHIJKLM

Anagrams, will allow us to get all the unique combinations of the strings and we produce the initial Arrays for both the sets.

The First Set of 6 Alphabets will generate 6! Or 720 unique combinations while the Second Set will generate 7! Or 5040 unique combinations

* Set 1: 720 - "ABCDEF", "ABCDFE", .... , "FEDCAB", "FEDCBA"
* Set 2: 5040 - "GHIJKLM", "GHIJKML",  …. , "MLKJIGH", "MLKJIHG"

Moreover the, 4 different suits will give rise to 4! Different combinations and these too can be assigned an Alphabet. 

Suit | Clubs | Diamonds | Hearts | Spades
:--- | :---: | :---: | :---: | :---:
Abbrevation | C | D | H | S
Weight | 0 | 13 | 26 | 39

Combinations | "HDSC" | "HDCS" | ... | "CSHD" | "CSDH"
:--- | :---: | :---: | :---: | :---: | :---: | :---:

Using these and some more additional reference lookup tables we can generate a DeckID of 6 Characters .

The DeckID, is not just about the Card and Suit combination, but also defines the position of the Jokers. 

The algorithm for DeckID generation is more of a compression algorithm for small strings, whose primary goal is to generate an output string consisting of Printable Characters ie. (Alpha-Numeric). The implementer may choose their favorite algorithm viz, SMAZ or Shoco 

Presently, Solitaire with Dynamic Decks has been designed as a proof of concept, wherein the DeckID has been demarcated by a “-” and sticks out like a sore-thumb, however, implementers may choose to mix the DeckID with the Solitaire Encryption Text.

<h4>Sample Data</h4>
* Random Deck No: 4581337
* Random Suit No:7
* Before Adding Jokers: MXjsPG,17,32,40,2,18,29,47,13,20,37,51,9,23,30,45,1,15,31,42,8,26,33,50,12,22,36,43,6,14,28,44,3,21,39,46,11,25,35,49,4,19,27,41,5,16,34,52,7,24,38,48,10
* Joker A Number_Left: 458 ; Sum:17
* Joker B Number_Right: 1337; Sum:14
* Joker B Position:39
* After Adding Jokers: MXjsPG,17,32,40,2,18,29,47,13,20,37,51,9,23,30,45,1,53,15,31,42,8,26,33,50,12,22,36,43,6,14,28,44,3,21,39,46,11,25,54,35,49,4,19,27,41,5,16,34,52,7,24,38,48,10
* Encrypted Text: VIUREZMWODHZRFKWZGRUTXJPHMIKVRGTXECA-MXjsPG

<h4>Proof of Concept</h4>
 <a href="http://j.mp/SolitaireEnc" target="_blank">Visit the Proof of Concept Site for Solitaire</a> 
