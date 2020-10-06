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
Local $TIMES = 1
Local $iSec, $iMin, $iHour

; calculate with time
Local $iStartTicks = _TimeToTicks(@HOUR, @MIN, @SEC)
; calculate 45 minutes later
Local $iEndTicks = $iStartTicks + $TIME_TO_RUN
Local $iNow = $iStartTicks

Local $iStepCount = 0
;;;
;;;DECLARACOES FIM
;;;

;;;
;;;FUNCOES
;;;
Func SetMaxAtacks($iatacks)
	$MAX_ATACKS  = $iatacks

EndFunc

Func SetTimesBeforeHeal($t)
	$TIMES  = $t

EndFunc

Func SetDuration($iMinutes)
	$TIME_TO_RUN  = 1000 * 60 * $iMinutes
	 $iEndTicks = $iStartTicks + $TIME_TO_RUN

EndFunc

Func SetMaxSteps($steps)
	$MAX_STEPS_WALK = $steps

EndFunc



Func EndGame()
	ConsoleWrite("Parando de jogar" & @CRLF)

EndFunc


Func Step2()
	;;Cada vez ele inverte iniciar pra cima ou pra baixo
	;;pra que estatisticamente ele tenha a mesma chance de
	;;andar uma distancia maior tanto pra cima  quanto pra baixo
	;;ao longo de muito tempo ele fica no mesmo lugar

	Local $sFirstStep
	Local $sSecondStep

	$iStepCount = $iStepCount + 1

	if Mod( $iStepCount , 2) = 0 Then
		$sFirstStep = "DOWN"
		$sSecondStep = "UP"
	Else
		$sFirstStep = "UP"
		$sSecondStep = "DOWN"
	EndIf

	Send("{" & $sFirstStep & " down}")
	Sleep(500)
	Send("{" & $sFirstStep & " up}")
	Send("{" & $sSecondStep & " down}")
	Sleep(500)
	Send("{" & $sSecondStep & " up}")



EndFunc

Func Walk()
	For $contSteps = 0 TO $MAX_STEPS_WALK
		Step2()
	Next

EndFunc

Func CleanupMenu()
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
	Sleep(500)
	Send("{c down}")
	Sleep(100)
	Send("{c up}")

EndFunc


Func FindMonsters()
	ConsoleWrite("Procurando monstros " & $cont  & @CRLF)
	CleanupMenu()
	Walk()

EndFunc

Func PrepareAtack()
	Send("{v down}")
	Sleep(100)
	Send("{v up}")
	Send("{c down}")
	Sleep(100)
	Send("{c up}")

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

EndFunc

Func AtackMonsters()
	Local $atacks

	ConsoleWrite("Atacando monstros" & @CRLF)
	For $atacks = 0 TO $MAX_ATACKS
		Atack()
		Sleep(2000)
	Next

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

Func OpenMagicMenu()
	Send("{v DOWN}")
	Sleep(1000)
	Send("{v UP}")
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	;;selecionando menu magia
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	;;selecionando o personagem
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	;;selecionando o tipo de magia MAGIC
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
EndFunc

Func ApplyAll()
	ConsoleWrite("Aplicando no Primeiro Jogador " &  @CRLF)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	ConsoleWrite("Aplicando no Segundo Jogador " &  @CRLF)
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	ConsoleWrite("Aplicando no Terceiro Jogador " &  @CRLF)
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
EndFunc

Func ApplyHeal()
	ConsoleWrite("Se curando..." &  @CRLF)
	CleanupMenu()
	OpenMagicMenu()
	;;selecionando a magia cura
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	Sleep(1000)
	ApplyAll()
	CleanupMenu()

EndFunc



Func ApplyRess()
	ConsoleWrite("Trazendo os mortos à vida..." &  @CRLF)
	CleanupMenu()
	OpenMagicMenu()
	;;selecionando a magia cura
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{DOWN DOWN}")
	Sleep(10)
	Send("{DOWN UP}")
	Sleep(1000)
	Send("{x DOWN}")
	Sleep(10)
	Send("{x UP}")
	ApplyAll()
	CleanupMenu()

EndFunc

Func StartTurn()
	ConsoleWrite("Iniciando novo turno " & $cont  & @CRLF)

	while $cont  < $TIMES And  $iNow < $iEndTicks

		StartRound()

	wend

	$cont = 1

	ApplyHeal()
	ApplyRess()

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
SetTimesBeforeHeal(3)
;;;
;;;CONFIGURACOES FIM
;;;


;StartGame()
;EndGame()
ActiveGameWindow()
ApplyHeal()
;;ApplyRess()