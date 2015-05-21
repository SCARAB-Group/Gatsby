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

   $winCheck = WinWait("Information", "", 6)
   If $winCheck <> 0 Then
	  Return False
   EndIf

   Return True

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
   ;WinWait("SPREC Codes Data", "", 1)
   Send("{ENTER}")
   WinWaitActive("SPREC Codes Data")
   ;Send("{ENTER}")

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


Func getGroupTestValueObject($groupName)
   If $testValuesAll.Exists($groupName) Then
	  return $testValuesAll.Item($groupName)
   EndIf
EndFunc

; Creates a new configuration object.
; Inputs:
; 	- Group name (string)
; 	- LIMS user name (string)
; 	- LIMS password (string)
;
; Note: requires the variable $groupConfigurations [local $groupConfigurations = ObjCreate("Scripting.Dictionary")]
Func createNewGroupConfig($groupName, $groupUser, $groupPass)
   $gConfig = ObjCreate("Scripting.Dictionary")
   $gConfig.ADD("user", $groupUser)
   $gConfig.ADD("pass", $groupPass)
   $groupConfigurations.ADD($groupName, $gConfig)
   $groupConfigurations.Item($groupName).ADD("TESTSCHEMES", ObjCreate("Scripting.Dictionary"))
   $groupConfigurations.Item($groupName).ADD("TESTVALUES", ObjCreate("Scripting.Dictionary"))
EndFunc

; Adds a new test scheme for a group
; Inputs:
; 	- Group name (string)
; 	- Test scheme name (string)
; 	- Test scheme definition (2D-array)
Func addNewTestScheme($groupName, $schemeName, $testArray)
   $groupConfigurations.Item($groupName).Item("TESTSCHEMES").ADD($schemeName, $testArray)
EndFunc

; Retreives a test scheme
; Inputs:
; 	- Group name (string)
; 	- Test scheme name (string)
;
; Outputs:
; 	- Test scheme definition (2D-array)
Func getTestScheme($groupName, $schemeName)
   Return $groupConfigurations.Item($groupName).Item("TESTSCHEMES").Item($schemeName)
EndFunc

; Adds a new test value for a group
; Inputs:
; 	- Group name (string)
; 	- Test value key/identifier (string)
; 	- The actual test value
Func addTestValue($groupName, $key, $value)
   $groupConfigurations.Item($groupName).Item("TESTVALUES").ADD($key, $value)
EndFunc

; Retreives a test value
; Inputs:
; 	- Group name (string)
; 	- Test value key/identifier
;
; Outputs:
; 	- The actual test value
Func getTestValue($groupName, $key)
   Return $groupConfigurations.Item($groupName).Item("TESTVALUES").Item($key)
EndFunc

