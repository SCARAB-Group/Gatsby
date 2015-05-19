#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:
	Run LIMS as a robot
	  N.B. Require Full windoW,

#ce ----------------------------------------------------------------------------

#include <File.au3>
#include <Constants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>

; =================================================
; Functions
; =================================================

;Propose added by PES - Support all resolutions
;Function to convert screen coordinates to support all res.
;XYa, XYb, XYc coords based on known good coords at 1280x800 resolution ?
#cs ########### EXAMPLE CALL ################
$windowXb = 174
$windowYb = 298
_ConvertXY($windowXb, $windowYb)
MouseClick("left", $windowXb, $windowYb)
#ce ########### /EXAMPLE CALL ###############

; ########### FUNCTION ######################
#cs
Func _ConvertXY(ByRef $Xin, ByRef $Yin)
     $Xin = Round( ($Xin / 1280) * @DesktopWidth )
     $Yin = Round( ($Yin / 800) * @DesktopHeight )
EndFunc
#ce
; ########### /FUNCTION #####################

Func mouseClickFcn($curWindow, $xpos, $ypos, $nrOfClick)
   ;ConsoleWrite("---------------" & @CRLF & "Starting LIMS.." & @CRLF)
   Local $hWnd = WinActivate($curWindow)
   MouseClick("primary", $xpos, $ypos, $nrOfClick)
   Return
EndFunc


Func loginLIMS($userInfoArray, $userIndex)
   ConsoleWrite("---------------" & @CRLF & "Logging in.." & @CRLF)
   WinWaitActive("LabWare LIMS")
   Send("!f")
   Send("i")
   Send("i")
   Send("{ENTER}")

   WinWaitActive("Please Log In")
   ;Send("test_molde")
   Send($userInfoArray[$userIndex][0])
   Send("{ENTER}")

   ;Send("abcd12345")
   Send($userInfoArray[$userIndex][1])
   Send("{ENTER}")

   Send("l")

   WinWaitActive("Please Log In")
   Send("!o")

   Return
EndFunc


Func logoutLIMS()
   ConsoleWrite("---------------" & @CRLF & "Logging out.." & @CRLF)
   WinWaitActive($curEnvironment)
   Send("!f")
   Send("o")

   Return
EndFunc



Func checkGuiFields()
   Return
EndFunc

Func handleSprecInput()
   ; TODO: Generalize this function
   WinWait("SPREC Codes Data", "", 1)
   WinWaitActive("SPREC Codes Data")
   Send("{ENTER}")

   Sleep(500)
   Send("o")
   Send("{ENTER}")

   Sleep(500)
   Send("1")
   Send("{ENTER}")

   Sleep(500)
   Send("1")
   Send("{ENTER}")

   Sleep(500)
   Send("1")
   Send("{ENTER}")

   Sleep(500)
   Send("1")
   Send("{ENTER}")

   Sleep(500)
   Send("c")
   Send("{ENTER}")

   Sleep(500)
   Send("Test comment")
   Send("{ENTER}")

   Send("{ENTER}")
   Send("!o")
   Return
EndFunc


Func checkSingleField($fieldType, $propInit, $propVal, $testVal ,$expOutcome, $fieldText, $sleepVal, $testType)
   ;ConsoleWrite("Current values: " & "|" & $fieldType & "|" &  $propVal & "|" & $expOutcome & "|" & $fieldText & "|" & $sleepVal & @CRLF )

   Switch $fieldType
	  Case "Skip"

		 ConsoleWrite("Skip detected"& @CRLF)
		 Sleep($sleepVal)
		 Send("{ENTER}")
		 Sleep($sleepVal)


	  Case "Text"
			Send($propVal)
			Send("{ENTER}")

	  Case "List"
		 ConsoleWrite("List detected"& @CRLF)
		 Sleep($sleepVal)
		 Send($propInit)
		 Send("{ENTER}")
		 Send("{ENTER}")

	  Case "Glass"
		 ConsoleWrite("Glass detected"& @CRLF)
		 Sleep($sleepVal)
		 Send($propInit)
		 Send("{ENTER}")
		 Sleep($sleepVal)
		 Send($propVal)
		 Send("{ENTER}")

	  Case "Sprec"
		 ConsoleWrite("Sprec detected"& @CRLF)
		 handleSprecInput()
		 WinWaitActive("Log sample")

	  Case "RadioButton"
		 ConsoleWrite("Radio Button detected"& @CRLF)
		 Sleep($sleepVal)
		 IF $propVal == "False" Then
			ConsoleWrite("Radio Button value (should be false): " & $propVal & @CRLF)

			Send("{RIGHT}")
			Send("{ENTER}")
		 ElseIf $propVal == "True" Then
			ConsoleWrite("Radio Button value (should be true): " & $propVal & @CRLF)
			Send("{LEFT}")
			Send("{ENTER}")
		 Else
			Send("{ENTER}")
		 EndIf

	  Case Else
		 Send("{ENTER}")
   EndSwitch


   checkErrorMsg($fieldType, $propInit, $propVal, $testVal ,$expOutcome, $fieldText, $sleepVal, $testType)
   ;Sleep(500)

   ConsoleWrite("------------------  End Switch"& @CRLF)

   Return
EndFunc


Func checkErrorMsg($fieldType, $propInit, $propVal, $testValSub ,$expOutcome, $fieldText, $sleepVal, $testType)
   local $winCheck2 = ""
   consolewrite("CheckErrorMsg: Waiting for info window" & @CRLF & "+++++++++++++++" & @CRLF)
   $winCheck2 = WinWait("Information", "", 1)
   IF $fieldText == "Personal number" Then
	  Send("+{TAB}")
   EndIf

   If $winCheck2 <> 0 Then
     $logMsg = "Code |101 Input Error, input value was not accepted: GUI: " & $curUserFunctionID & " | Field: "  & $fieldText & " | Testtype: "  & $testType  & " | Input: "  & $propVal
     logEvent($logMsg, @ScriptDir & "\Example.log")

     WinClose($winCheck2)
     WinActive($curUserFunctionID)

   Else
      $logMsg = "OK, input value was accepted: GUI: " & $curUserFunctionID & " | Field: "  & $fieldText & " | Testtype: "  & $testType  & " | Input: "  & $propVal
	  logEvent($logMsg, @ScriptDir & "\Example.log")


   EndIf



   Return
 EndFunc


Func closeUserDialog()

   Send("!o")
   local $winCheck = ""
   $winCheck = WinWait("Information", "", 2)

   If $winCheck <> 0 Then
     $logMsg = "Code |103 Login form value, Login values were missing/not accepted, no sample was logged. Current user dialog: " & $curUserFunctionID
     logEvent($logMsg, @ScriptDir & "\Example.log")

     WinClose($winCheck)
     WinActive($curUserFunctionID)
     Send("!c")
  Else

	  ; Handle exception for log sample dialog, end sample log and handle sample grid window
	  If $curUserFunctionID == "Log sample" Then
		 handleSampleGridWindow()
	  EndIf

   EndIf


   Return
 EndFunc


Func handleSampleGridWindow()

   Sleep(2000)
   WinWaitActive("Log sample")
   Send("!c")

   WinWaitActive("Modify Samples Dialog")
   Send("!f")
   Send("x")

   Return
EndFunc




Func testField($curfieldType, $curProposedInit, $curProposedValue, $curTestValue, $curExpectedOutcome, $curFieldText, $curSleepValue, $curTestType)
   ConsoleWrite("Testing for malware code"& @CRLF)
   local $logMsg = ""
   local $winCheck = ""
   Sleep($curSleepValue)
   Send($curTestValue)
   Send("{ENTER}")

   $winCheck = WinWait("Information", "", 6)

   $logMsg = "Test #01 initiated. GUI: " & $curUserFunctionID & " | Field: "  & $curFieldText & " | Testtype: "  & $curTestType  & " | TestInput: "  & $curTestValue
   logEvent($logMsg, @ScriptDir & "\Example.log")

   If $winCheck == 0 Then
	  $logMsg = "Test failed! No warnings about sql injection appeared, Bummer.. "
	  logEvent($logMsg, @ScriptDir & "\Example.log")

   Else
	  WinClose($winCheck)
	  WinActive($curUserFunctionID)
	  $logMsg = "Test OK, Error message appeared "
      logEvent($logMsg, @ScriptDir & "\Example.log")

	  Send("+{TAB}")
	  Sleep($curSleepValue)

	  checkSingleField($curfieldType, $curProposedInit, $curProposedValue, $curTestValue ,$curExpectedOutcome, $curFieldText, $curSleepValue, $curTestType)

	  ;Send($curProposedValue)
	  ;Send("{ENTER}")
   EndIf

   ;logEvent($logMsg, @ScriptDir & "\Example.log")
   ;_FileWriteLog(@ScriptDir & "\Example.log", $logMsg, -1)

   Return
EndFunc



Func logEvent($logMsg, $logFilename)
   _FileWriteLog($logFilename, $logMsg, -1)
   Return
EndFunc


