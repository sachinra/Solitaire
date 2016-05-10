# Solitaire
Solitaire Encryption with Dynamic Decks

# BRIEF 
The Solitaire cryptographic algorithm was designed by Bruce Schneier to allow field agents to communicate securely without having to rely on electronics or having to carry incriminating tools, at the request of Neal Stephenson for use in his novel Cryptonomicon. It was designed to be a manual cryptosystem calculated with an ordinary deck of playing cards. In Cryptonomicon, this algorithm was originally called Pontifex to hide the fact that it involved playing cards.

#REQUIREMENTS
A deck of Cards with Two Jokers

#THEORY 
A deck of cards provides us with 54! possible combinations of the arrangement of cards in the deck. Using one such deck combination, we move ahead with the KeyStream Generation, which is the heart of the Solitaire Cipher. When implemented with a PassPhrase then prior to generating KeyStream, the cards have to shuffled using the method described for PassPhrase Shuffle.

Since, Solitaire Cipher, is an output-feedback mode stream cipher, the KeyStream Generator will throw out One Card at the end of every KeyStream generation process, and this process is basically shuffling of cards based on the described method. 

The reason for generating KeyStream is that for every character of the Plaintext ,a unique Keystream Character is generated and upon the completion of this entire process, the number associated with the alphabets of both the Plaintext and the KeyStream are added to generate a new number , and subsequently the character associated with this newly generated Number becomes the Solitaire Cipher Text.

Let us take a hypothetical example, wherein, a Random Combination of Deck is used which generates the below mentioned KeyStream.

Plain Text 	: THISWORKS	: Length : 9 characters
Key Stream	: AJUTRNFHD	: Length : 9 characters
Cipher Text	: URDMOGUSW	: Length : 9 characters

In order to generate the cipher text, we shall rely on a table which associates the Alphabets to their corresponding number. Ie. A = 1 , B = 2 ….. Y = 25 , Z = 26

# IMPLEMENTATION
From a holistic point of view, the basic requirement for implementing this is that both the processes ie. Encryption and Decryption processes should be aware of the following 

1: The Deck Combination Order.

2: Passphrase , (If any)

However, when we have to implement this cipher for (non-sensitive) Digital Communications, the paradigm shifts drastically, as the information between the sender and the receiver can be intercepted and the cipher-message can be brute forced, especially when multiple messages with the same passphrase are generated.

The simple reason being, the deck combination never changes, as changing the deck combination would provide incorrect output after decryption. Moreover, the passphrase also needs to be known to both the parties / programs. It is also stated that after sending every message the pass-phrase needs to be changed so as to raise the level of difficulty for those who are intercepting the messages.

Due to this we now have two parameters, which are deemed crucial for a successful implementation, and have to be known to both the parties. 

In order to take advantage of Solitaire Cipher and its 54! Combinations, with the additional PassPhrase and reducing the overheads of sending the entire deck of cards to the recipient, we shall instead rely on associating ID Tags with a subset of deck combinations ie. 6! * 7!. 

This particular method would now be dependent on those who are implementing Solitaire Cipher. Moreover, the implementers may choose to randomize the associating tables in case of a breach.

It is also to be noted that, even though this method of Tag-IDs is not fool-proof however, it does provide an edge over the conventional implementation of Solitaire Cipher. 

# DECK-ID GENERATION
As we all know, every deck has 13 cards belonging to 4 different suits. We begin by breaking up the 13 cards into two different sets of 6 cards and 7 cards and associating every card with a particular Alphabet. The implementer over here may choose their own set of cards to be a part of which group. 

______________________________________

|Deck    A	2	3	4	5	6	7	8	9	10 J Q K |

|Random  A	B	C	D	E	F	G	H	I  J K L M |

______________________________________

First Set : ABCDEF

Second Set: GHIJKLM

Anagrams, will allow us to get all the unique combinations of the strings and we produce the initial Arrays for both the sets.

The First Set of 6 Alphabets will generate 6! Or 720 unique combinations while the Second Set will generate 7! Or 5040 unique combinations

Moreover the, 4 different suits will give rise to 4! Different combinations and these too can be assigned an Alphabet. 

________________________________________

|Suite  Clubs Diamonds  Hearts  Spades |

|       C	    D	        H	      S      |

|Weight 0     13        26      39     |

________________________________________

Combinations : 
"HDSC", "HDCS", "HSDC", "HSCD", "HCDS", "HCSD", "DHSC", "DHCS", "DSHC", "DSCH", "DCHS", "DCSH", 	"SHDC", "SHCD", "SDHC", "SDCH", "SCHD", "SCDH", "CHDS", "CHSD", "CDHS", "CDSH", "CSHD", "CSDH"

