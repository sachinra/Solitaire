# Solitaire #
Solitaire Encryption with Dynamic Decks

<h4>BRIEF</h4>
<p>The Solitaire cryptographic algorithm was designed by Bruce Schneier to allow field agents to communicate securely without having to rely on electronics or having to carry incriminating tools, at the request of Neal Stephenson for use in his novel Cryptonomicon. It was designed to be a manual cryptosystem calculated with an ordinary deck of playing cards. In Cryptonomicon, this algorithm was originally called Pontifex to hide the fact that it involved playing cards.</p>

<h4>REQUIREMENTS</h4>
<p>A deck of Cards with Two Jokers</p>

<h4>THEORY</h4>
<p>A deck of cards provides us with 54! possible combinations of the arrangement of cards in the deck. Using one such deck combination, we move ahead with the KeyStream Generation, which is the heart of the Solitaire Cipher. When implemented with a PassPhrase then prior to generating KeyStream, the cards have to shuffled using the method described for PassPhrase Shuffle.</p>
<p>Since, Solitaire Cipher, is an output-feedback mode stream cipher, the KeyStream Generator will throw out One Card at the end of every KeyStream generation process, and this process is basically shuffling of cards based on the described method.</p>
<p>The reason for generating KeyStream is that for every character of the Plaintext ,a unique Keystream Character is generated and upon the completion of this entire process, the number associated with the alphabets of both the Plaintext and the KeyStream are added to generate a new number , and subsequently the character associated with this newly generated Number becomes the Solitaire Cipher Text.</p>
<p>Let us take a hypothetical example, wherein, a Random Combination of Deck is used which generates the below mentioned KeyStream.</p>
* Plain Text 	: THISWORKS	: Length : 9 characters
* Key Stream	: AJUTRNFHD	: Length : 9 characters
* Cipher Text	: URDMOGUSW	: Length : 9 characters
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
<table class="tftable" border="1">
    <tr>
        <td>Deck</td>
        <td>A</td>
        <td>2</td>
        <td>3</td>
        <td>4</td>
        <td>5</td>
        <td>6</td>
        <td>7</td>
        <td>8</td>
        <td>9</td>
        <td>10</td>
        <td>J</td>
        <td>Q</td>
        <td>K</td>
    </tr>
    <tr>
        <td>Random</td>
        <td>A</td>
        <td>B</td>
        <td>C</td>
        <td>D</td>
        <td>E</td>
        <td>F</td>
        <td>G</td>
        <td>H</td>
        <td>I</td>
        <td>J</td>
        <td>K</td>
        <td>L</td>
        <td>M</td>
    </tr>
</table>
______________________________________

* First Set : ABCDEF
* Second Set: GHIJKLM

Anagrams, will allow us to get all the unique combinations of the strings and we produce the initial Arrays for both the sets.

The First Set of 6 Alphabets will generate 6! Or 720 unique combinations while the Second Set will generate 7! Or 5040 unique combinations

* Set 1: 720 - "ABCDEF", "ABCDFE", .... , "FEDCAB", "FEDCBA"
* Set 2: 5040 - "GHIJKLM", "GHIJKML",  …. , "MLKJIGH", "MLKJIHG"

Moreover the, 4 different suits will give rise to 4! Different combinations and these too can be assigned an Alphabet. 

________________________________________
<table class="tftable" border="1">
<tr><th>Suit</th><th>Clubs</th><th>Diamonds</th><th>Hearts</th><th>Spades</th></tr>
<tr><td>Abbrevation</td><td>C</td><td>D</td><td>H</td><td>S</td></tr>
<tr><td>Weight</td><td>0</td><td>13</td><td>26</td><td>39</td></tr>
</table>
________________________________________

* Combinations : "HDSC", "HDCS", …., "CSHD", "CSDH"

Using these and some more additional reference lookup tables we can generate a DeckID of 6 Characters .

The DeckID, is not just about the Card and Suit combination, but also defines the position of the Jokers. 

The algorithm for DeckID generation is more of a compression algorithm for small strings, whose primary goal is to generate an output string consisting of Printable Characters ie. (Alpha-Numeric). The implementer may choose their favorite algorithm viz, SMAZ or Shoco 

Presently, Solitaire with Dynamic Decks has been designed as a proof of concept, wherein the DeckID has been demarcated by a “-” and sticks out like a sore-thumb, however, implementers may choose to mix the DeckID with the Solitaire Encryption Text.
