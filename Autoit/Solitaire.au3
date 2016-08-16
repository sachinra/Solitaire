#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Solitaire_Deck.exe
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Fileversion=0.1.0.9
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Solitaire Encryption - Designed by: Bruce Schneier : Author for Deck ID Generation :Sachin R. <sachinr@escanav.com>
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <SolitaireUDF.au3>

Local $numLeft = StringFormat("%03i", Random(1, 720, 1))
Local $numRight = StringFormat("%04i", Random(1, 5040, 1))
Local $nDeckNo = Random(1, 24, 1)
Local $numberGen = $numLeft & $numRight
Local $begin = TimerInit()
Local $sPlainText = "THEQUICKBROWNFOXJUMPEDOVERTHELAZYDOG"
Local $sPassPhrase = "QWERTY"

ConsoleWrite(@CRLF & @TAB & "---Solitaire Encryption with Dynamic Decks---" & @CRLF)
ConsoleWrite(@TAB & "Solitaire Encryption - by: Bruce Schneier" & @CRLF & @TAB & "Deck ID Generation by: Sachin R. <sachinr@escanav.com> " & @CRLF)
ConsoleWrite(@CRLF & @TAB & "***********************************" & @CRLF & @CRLF)
ConsoleWrite(@TAB & "Plain Text      : " & $sPlainText & @CRLF)
ConsoleWrite(@TAB & "Pass Phrase     : " & $sPassPhrase & @CRLF)
ConsoleWrite(@CRLF & @TAB & "***********************************" & @CRLF & @CRLF)

$sPlainText = StringStripWS(StringUpper($sPlainText), 8)
$sPassPhrase = StringStripWS(StringUpper($sPassPhrase), 8)
ConsoleWrite(@TAB & "Random Deck No  : " & $numberGen & @CRLF)
ConsoleWrite(@TAB & "Random Suit No  : " & $nDeckNo & @CRLF)

$sSolitaire_Chipher = Solitaire_Encrypt_Process($numberGen, $nDeckNo, $sPlainText, $sPassPhrase)
ConsoleWrite(@TAB & "Encrypted Text  : " & $sSolitaire_Chipher & @CRLF)
ConsoleWrite(@CRLF & @TAB & "***********************************" & @CRLF & @CRLF)

$sPlainText = Solitaire_Decrypt_Process($sSolitaire_Chipher, $sPassPhrase)
ConsoleWrite(@TAB & "Decrypted Text  : " & $sPlainText & @CRLF)
ConsoleWrite(@TAB & "Execution Time  : " & TimerDiff($begin) / 1000 & " Sec." & @CRLF)
ConsoleWrite(@CRLF & @TAB & "***********************************" & @CRLF & @CRLF)

Exit 1
