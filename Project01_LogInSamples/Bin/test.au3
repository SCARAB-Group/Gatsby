#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:
	Open somehting
	  N.B. Require Full windoW,

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <File.au3>
#include <Constants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>

$winCheck = WinWait("Information", "", 2)
Local $sText = WinGetText($winCheck)
;WinClose($winCheck)



;WinWaitActive("Information")
;WinActive("Information")

   ; Retrieve the window text of the active window.
   ;Local $sText = WinGetText("[ACTIVE]")



    ; Display the window text.
    MsgBox($MB_SYSTEMMODAL, "", $sText)




;ConsoleWrite("Starting log event" & @CRLF)

;Local $arr[2][2] = [ [1, 2], [3, 4] ]

;Local $sub = $arr[1][1]

;ConsoleWrite("TestVal: " & $sub & @CRLF)

;For $item in $aArray
;   ConsoleWrite($item & @CRLF)
;Next







