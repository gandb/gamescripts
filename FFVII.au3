#include <Constants.au3>
#include <Date.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at autoitscript dot com)
;
; Script Function:
;   Opens Notepad, types in some text and then quits the application.
;

WinActivate("FINAL FANTASY VII")


Local $TIME_TO_RUN = 1000 * 60 * 1 ;milis * sec * minutes * hour

; Now that the Notepad window is active type some text
;Send("{DOWN 6}")

Local $cont = 1
Local $TIMES = 64
Local $iSec, $iMin, $iHour

; calculate with time
Local $iStartTicks = _TimeToTicks(@HOUR, @MIN, @SEC)
; calculate 45 minutes later
Local $iEndTicks = $iStartTicks + $TIME_TO_RUN

Local $iNow = $iStartTicks


while  $iNow < $iEndTicks

	while $cont  < $TIMES And  $iNow < $iEndTicks

		$iNow = _TimeToTicks(@HOUR, @MIN, @SEC)

		ConsoleWrite("Procurando monstros " & $cont  & @CRLF)
		Send("{UP down}{LEFT down}")
		Sleep(20000);
		Send("{UP up}{LEFT up}")
		Sleep(100)
		Send("{RIGHT}")
		Send("{DOWN}")
		ConsoleWrite("Atacando monstros" & @CRLF)
		Send("c")
		Sleep(1000)
		Send("c")
		Sleep(1000)
		Send("c")
		Sleep(1000)
		Send("c")
		Sleep(1000)
		Send("c")
		Send("{x down}")
		Sleep(40000) ;30000-37000
		Send("{x up}")
		ConsoleWrite("Pegando XP" & @CRLF)
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("xxxxxx")
		ConsoleWrite("Pegando Itens" & @CRLF)
		Sleep(2000)
		Send("xxxxx")
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("ccccc")
		Sleep(2000)
		Send("{DOWN}")
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("ccccc")
		Sleep(2000)
		Send("{DOWN}")
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("ccccc")
		Sleep(2000)
		Send("{DOWN}")
		Sleep(2000)
		Send("xxxxxx")
		Sleep(2000)
		Send("ccccc")
		Sleep(2000)
		Send("{DOWN}")
		Sleep(2000)

		$cont  = 1 + $cont

	wend

	ConsoleWrite("Final de rodada" & @CRLF)
wend

ConsoleWrite("Parando de jogar" & @CRLF)