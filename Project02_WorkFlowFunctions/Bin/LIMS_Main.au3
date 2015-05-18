#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:Select

	Run LIMS as a robot
	  N.B. Require Full windoW,

#ce ----------------------------------------------------------------------------

#include <Functions.au3>
#include <Configuration.au3>
#include <TestSchemes.au3>

; =================================================
; Main
; =================================================
$row01Start_yval = 340
$row02Start_yval = 630
$ydelta = 38

$col01_xval = 650
$col02_xval = 1000
$col03_xval = 1300

;["Log sample", $col02_xval, $row01Start_yval + $ydelta * 1, "Log sample" ], _


;Local $workFlowPositions[2][2] = [ [1000, 365], [1300, 365] ]





WinActive("LIMS_BB_DEV")
For $curFunction = 0 To 29
   $xpos = $wfDef_KISLL_RGPM[$curFunction][1]
   $ypos = $wfDef_KISLL_RGPM[$curFunction][2]
   $nrOfClick = 1
   MouseClick("primary", $xpos, $ypos, $nrOfClick)

   $actionType = $wfDef_KISLL_RGPM[$curFunction][4]
   Switch $actionType
	  Case "1"

		 $winCheck = WinWait($wfDef_KISLL_RGPM[$curFunction][3], "", 2)
		 ;sleep(1000)
		 If $winCheck <> 0 Then
			WinClose($winCheck)
		 EndIf
	  Case "2"
		 Send("!n")
	  Case "3"
		 Send("!c")
	  Case "4"
		 Sleep(3000)

   EndSwitch

Next





