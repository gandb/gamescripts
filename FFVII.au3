#include <Constants.au3>
#include <Date.au3>

;
; Platform:       Win9x/NT
; Author:         Edson Vicente Carli Junior
;
;

;;;
;;;DECLARACOES
;;;
Local $TIME_TO_RUN = 0
local $MAX_STEPS_WALK = 0
Local $MAX_ATACKS = 0

Local $cont = 1
Local $TIMES = 32
Local $iSec, $iMin, $iHour

; calculate with time
Local $iStartTicks = _TimeToTicks(@HOUR, @MIN, @SEC)
; calculate 45 minutes later
Local $iEndTicks = $iStartTicks + $TIME_TO_RUN
Local $iNow = $iStartTicks
;;;
;;;DECLARACOES FIM
;;;

;;;
;;;FUNCOES
;;;
Func SetMaxAtacks($iatacks)
	$MAX_ATACKS  = $iatacks
    Return True
EndFunc

Func SetDuration($iMinutes)
	$TIME_TO_RUN  = 1000 * 60 * $iMinutes
	 $iEndTicks = $iStartTicks + $TIME_TO_RUN
    Return True
EndFunc

Func SetMaxSteps($steps)
	$MAX_STEPS_WALK = $steps
    Return True
EndFunc



Func EndGame()
	ConsoleWrite("Parando de jogar" & @CRLF)
    Return True
EndFunc


Func Step2()
	Send("{UP down}")
	Sleep(500)
	Send("{UP up}")
	Send("{DOWN down}")
	Sleep(500)
	Send("{DOWN up}")
    Return True
EndFunc

Func Walk()
	For $contSteps = 0 TO $MAX_STEPS_WALK
		Step2()
	Next
    Return True
EndFunc


Func FindMonsters()
	ConsoleWrite("Procurando monstros " & $cont  & @CRLF)
	Send("{c down}")
	Sleep(100)
	Send("{c up}")
	Sleep(500)
	Send("{c down}")
	Sleep(100)
	Send("{c up}")
	Sleep(500)
	Send("{c down}")
	Sleep(100)
	Send("{c up}")
	Sleep(500)
	Send("{c down}")
	Sleep(100)
	Send("{c up}")
	Walk()
    Return True
EndFunc

Func PrepareAtack()
	Send("{v down}")
	Sleep(100)
	Send("{v up}")
	Send("{c down}")
	Sleep(100)
	Send("{c up}")
    Return True
EndFunc

Func Atack()
	PrepareAtack()
	Send("{x down}")
	Sleep(100)
	Send("{x up}")
	Send("{x down}")
	Sleep(100)
	Send("{x up}")
	Send("{x down}")
	Sleep(100)
	Send("{x up}")
    Return True
EndFunc

Func AtackMonsters()
	Local $atacks

	ConsoleWrite("Atacando monstros" & @CRLF)
	For $atacks = 0 TO $MAX_ATACKS
		Atack()
		Sleep(2000)
	Next
    Return True
EndFunc

Func GetXP()
	ConsoleWrite("Pegando XP" & @CRLF)
	Sleep(2000)
	Send("xxxxxx")
	Sleep(2000)
	Send("xxxxxx")
	Sleep(2000)
	Send("xxxxxx")
EndFunc


Func GetItens()
	ConsoleWrite("Pegando Itens" & @CRLF)
	Sleep(2000)
	Send("xxxxxx")
	Sleep(2000)
	Send("xxxxxx")
	Sleep(2000)
	Send("xxxxxx")
EndFunc

Func StartRound()
	ConsoleWrite("Iniciando nova rodada " & $cont  & @CRLF)

	$iNow = _TimeToTicks(@HOUR, @MIN, @SEC)

	FindMonsters()

	AtackMonsters()

	GetXP()

	GetItens()

	$cont  = 1 + $cont
EndFunc



Func ApplyHeal()
	ConsoleWrite("Se curando..." &  @CRLF)
	Send("{v DOWN}")
	Sleep(1000)
	Send("{v UP}")
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	ConsoleWrite("Curando Primeiro Jogador " &  @CRLF)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	ConsoleWrite("Curando Segundo Jogador " &  @CRLF)
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	ConsoleWrite("Curando Terceiro Jogador " &  @CRLF)
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Send("{c DOWN}")
	Sleep(10)
	Send("{c UP}")
	Send("{c DOWN}")
	Sleep(10)
	Send("{c UP}")
	Send("{c DOWN}")
	Sleep(10)
	Send("{c UP}")
	Sleep(1000)
    Return True
EndFunc

Func StartTurn()
	ConsoleWrite("Iniciando novo turno " & $cont  & @CRLF)

	while $cont  < $TIMES And  $iNow < $iEndTicks

		StartRound()

	wend

	$cont = 1

	ApplyHeal()

	ConsoleWrite("Final de rodada" & @CRLF)
EndFunc

Func ActiveGameWindow()
	WinActivate("FINAL FANTASY VII")
EndFunc


Func StartGame()
	ConsoleWrite("Iniciando jogo por " & $TIME_TO_RUN/60000 & " minutos "  & @CRLF)

	ActiveGameWindow()

	while  $iNow < $iEndTicks
		StartTurn()
	wend

    Return True
EndFunc
;;;
;;;FUNCOES FIM
;;;

;;;
;;;CONFIGURACOES
;;;
SetDuration(30)
SetMaxSteps(20)
SetMaxAtacks(15)
;;;
;;;CONFIGURACOES FIM
;;;


StartGame()
EndGame()
;;ActiveGameWindow()
;;ApplyHeal()