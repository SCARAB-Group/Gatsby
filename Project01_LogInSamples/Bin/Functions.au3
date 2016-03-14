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

Func loginLIMS($groupName)
   ConsoleWrite("---------------" & @CRLF & "Logging in.." & @CRLF)
   WinWaitActive("LabWare LIMS")
   Send("!f")
   Send("i")
   Send("i")
   Send("{ENTER}")

   WinWaitActive("Please Log In")
   Send(getUserName($groupName))
   Send("{ENTER}")

   Send(getPassword($groupName))
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

;~ Func loginLIMS($userInfoArray, $userIndex)
;~    ConsoleWrite("---------------" & @CRLF & "Logging in.." & @CRLF)
;~    WinWaitActive("LabWare LIMS")
;~    Send("!f")
;~    Send("i")
;~    Send("i")
;~    Send("{ENTER}")

;~    WinWaitActive("Please Log In")
;~    ;Send("test_molde")
;~    Send($userInfoArray[$userIndex][0])
;~    Send("{ENTER}")

;~    ;Send("abcd12345")
;~    Send($userInfoArray[$userIndex][1])
;~    Send("{ENTER}")

;~    Send("l")

;~    WinWaitActive("Please Log In")
;~    Send("!o")

;~    $winCheck = WinWait("Information", "", 6)
;~    If $winCheck <> 0 Then
;~ 	  Return False
;~    EndIf

;~    Return True

;~ EndFunc


Func logoutLIMS()
   ConsoleWrite("---------------" & @CRLF & "Logging out.." & @CRLF)
   logEvent("Logging out..." & @CRLF, @ScriptDir & "\Example.log")
   WinWaitActive($curEnvironment)
   Send("!f")
   Send("o")
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

   Sleep($stdSleep)
   Send("o")
   Send("{ENTER}")

   Sleep($stdSleep)
   Send("1")
   Send("{ENTER}")

   Sleep($stdSleep)
   Send("1")
   Send("{ENTER}")

   Sleep($stdSleep)
   Send("1")
   Send("{ENTER}")

   Sleep($stdSleep)
   Send("1")
   Send("{ENTER}")

   Sleep($stdSleep)
   Send("c")
   Send("{ENTER}")

   Sleep($stdSleep)
   Send("Test comment")
   Send("{ENTER}")

   Send("{ENTER}")
   Send("!o")

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
		 Sleep($sleepVal)
		 Send($propVal)
		 Send("{ENTER}")

	  Case "List"
		 ConsoleWrite("List detected"& @CRLF)
		 Sleep($sleepVal)

;~ 		 ; Possible to open a list using F4 and then type in selection name
;~ 		 If propVal <> "" Then
;~ 			send("F4")

		 Send($propInit)
		 Send("{ENTER}")
		 ;Send("{ENTER}")

	  Case "Glass"
		 ConsoleWrite("Glass detected"& @CRLF)
		 Sleep($sleepVal)
		 Send($propInit)
		 Send("{ENTER}")
		 Sleep($sleepVal)
		 if($propVal <> "") then
			Send($propVal)
			Send("{ENTER}")
		 Else
			ConsoleWrite("No value entered"& @CRLF)
		 EndIf

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

	  Case "Click"
		 ; propVal must be a 2D-array with x and y coordinates
		 ; fieldText is used to identify the window that opens on click
		 mouseClickFcn($curEnvironment, $propVal[0], $propVal[1], 1)
		 ConsoleWrite("Waiting for window: " & $fieldText & @CRLF)
		 WinWaitActive($fieldText)
		 Sleep($sleepVal)

	  Case "ClickOK"
		 clickOK($fieldText)

	  Case "CloseDialog" ; Close by pressing File -> close
		 Sleep($sleepVal)
		 closeDialog()

	  Case "CloseUserDialog" ; Close by pressing a close button
		 Sleep($sleepVal)
		 closeUserDialog($fieldText)

	  Case "DismissDialog"
		 Sleep($sleepVal)
		 dismissDialog($fieldText)

	  Case Else
		 Send("{ENTER}")
   EndSwitch


   checkErrorMsg($fieldType, $propInit, $propVal, $testVal ,$expOutcome, $fieldText, $sleepVal, $testType)
   ;Sleep(500)

   ConsoleWrite("------------------  End Switch"& @CRLF)

   Return
EndFunc


Func checkErrorMsg($fieldType, $propInit, $propVal, $testValSub ,$expOutcome, $fieldText, $sleepVal, $testType)
   ; FieldTypes/events in this list does not assume a popup if something is wrong
   Local $fieldTypeExceptions[6] = ["ClickOK", "CloseUserDialog", "CloseDialog", "DismissDialog", "Skip", "Click"]

   If _ArraySearch($fieldTypeExceptions, $fieldType) = -1 Then ; exception field type not found

	  local $winCheck2 = ""
	  consolewrite("CheckErrorMsg: Waiting for info window" & @CRLF & "+++++++++++++++" & @CRLF)
	  $winCheck2 = WinWait("Information", "", 1)

	  ; Skipping fields should be done using the skip function in the test scheme array instead
   ;~    IF $fieldText == "Personal number" Then
   ;~ 	  Send("+{TAB}")
   ;~    EndIf

	  If $winCheck2 <> 0 Then
		$logMsg = "Code |101 Input Error, input value was not accepted: Test scheme: " & $testSchemeName & " | Type: " & $fieldType & " | Field: "  & $fieldText & " | Testtype: "  & $testType  & " | Input: "  & $propVal
		logEvent($logMsg, @ScriptDir & "\Example.log")

		WinClose($winCheck2)
		WinActive($testSchemeName)

	  Else
		 $logMsg = "OK, input value was accepted." & " | Type: " & $fieldType &  " | Field: "  & $fieldText & " | Testtype: "  & $testType  & " | Input: "  & $propVal
		 logEvent($logMsg, @ScriptDir & "\Example.log")
	  EndIf

   Else
	  ConsoleWrite("Event: " & $fieldType & " - OK" & @CRLF)
	  $logMsg = "Event: " & $fieldType & " - OK." & " | Type: " & $fieldType &  " | Field: " & $fieldText & " | Testtype: "  & $testType  & " | Input: "  & $propVal
	  logEvent($logMsg, @ScriptDir & "\Example.log")

   EndIf

 EndFunc


Func clickOK($userDialogName)
   ConsoleWrite("ClickOK event")
   Send("!o")

   If ($userDialogName = "Log sample") OR ($userDialogName = "Log sample (Scan field)") Then
	  ConsoleWrite(" - Log sample window" & @CRLF)
	  local $winCheck = ""
	  $winCheck = WinWait("Information", "", 2)

	  If $winCheck <> 0 Then
		$logMsg = "Code |103 Login form value, Login values were missing/not accepted, no sample was logged."
		logEvent($logMsg, @ScriptDir & "\Example.log")

		WinClose($winCheck)
		WinActive($userDialogName)
		Send("!c")
	 Else
		 ConsoleWrite("Logging sample.... waiting " & $logSampleSleepValue & " ms" & @CRLF)
		 Sleep($logSampleSleepValue)
		 $logMsg = "Sample logged successfully!"
		 logEvent($logMsg, @ScriptDir & "\Example.log")
		 closeUserDialog($userDialogName)
		 handleSampleGridWindow()

		 ; Handle exception for log sample dialog, end sample log and handle sample grid window
		 ;If $testSchemeName == "Log sample" Then

		 ;EndIf

	  EndIf

   EndIf

   ConsoleWrite(@CRLF)

EndFunc

; Close by pressing a "close" button
Func closeUserDialog($userDialogName)
   ConsoleWrite(@TAB & "closeUserDialog - waiting for dialog: " & $userDialogName & @CRLF)
   Sleep($stdSleep)
   WinWaitActive($userDialogName)
   ConsoleWrite(@TAB & "closeUserDialog - about to close dialog: " & $userDialogName & @CRLF)
   Send("!c")
   ConsoleWrite(@TAB & "closeUserDialog - dialog closed" & @CRLF)
EndFunc

; Close by pressing File -> Exit
Func closeDialog()
   Send("!f")
   Send("x")
EndFunc

; Close by using the WinClose method
Func dismissDialog($userDialogName)
   ;ConsoleWrite(@TAB & "dismissDialog - waiting for dialog: " & $userDialogName & @CRLF)
   Sleep($stdSleep)
   WinWaitActive($userDialogName)
   ConsoleWrite(@TAB & "dismissDialog - about to close dialog: " & $userDialogName & @CRLF)
   WinClose($userDialogName)
   ConsoleWrite(@TAB & "dismissDialog - dialog closed" & @CRLF)
EndFunc

Func handleSampleGridWindow()

;~    Sleep(2000)
;~    WinWaitActive("Log sample")
;~    Send("!c")

   ;WinWaitActive("Modify Samples Dialog")
   WinWait("Modify Samples Dialog", "", 3)
   Send("!f")
   Send("x")

   ;Return
EndFunc

Func testField($curfieldType, $curProposedInit, $curProposedValue, $curTestValue, $curExpectedOutcome, $curFieldText, $curSleepValue, $curTestType)
   ConsoleWrite("Testing for malware code"& @CRLF)
   local $logMsg = ""
   local $winCheck = ""
   Sleep($curSleepValue)
   Send($curTestValue)
   Send("{ENTER}")

   $winCheck = WinWait("Information", "", 6)

   $logMsg = "Test #01 initiated. Test scheme: " & $testSchemeName & " | Field: "  & $curFieldText & " | Testtype: "  & $curTestType  & " | TestInput: "  & $curTestValue
   logEvent($logMsg, @ScriptDir & "\Example.log")

   If $winCheck == 0 Then
	  $logMsg = "Test failed! No warnings about sql injection appeared, Bummer.. "
	  logEvent($logMsg, @ScriptDir & "\Example.log")

   Else
	  WinClose($winCheck)
	  WinActive($testSchemeName)
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

;~ Func getGroupTestValueObject($groupName)
;~    If $testValuesAll.Exists($groupName) Then
;~ 	  return $testValuesAll.Item($groupName)
;~    EndIf
;~ EndFunc

; Creates a new configuration object.
; Inputs:
; 	- Group name (string)
; 	- LIMS user name (string)
; 	- LIMS password (string)
;
; Note: requires the variable $groupConfigurations [local $groupConfigurations = ObjCreate("Scripting.Dictionary")]
Func createGroupConfig($groupName, $groupUser, $groupPass)
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
Func addTestScheme($groupName, $schemeName, $testArray)
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

; Retreives all test schemes for a group
; Inputs:
; 	- Group name (string)
; 	- Test scheme name (string)
;
; Outputs:
; 	- Test scheme definitions (Scripting.Dictionary)
Func getTestSchemes($groupName)
   Return $groupConfigurations.Item($groupName).Item("TESTSCHEMES")
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

; Retreives the LIMS user name for a group
; Inputs:
; 	- Group name (string)
;
; Outputs:
; 	- LIMS user name (string)
Func getUserName($groupName)
   Return $groupConfigurations.Item($groupName).Item("user")
EndFunc

; Retreives the LIMS password for a group
; Inputs:
; 	- Group name (string)
;
; Outputs:
; 	- LIMS password (string)
Func getPassword($groupName)
   Return $groupConfigurations.Item($groupName).Item("pass")
EndFunc

; Convenience function, returns a string with today's date and the current time with spaces,
; dashes and colons removed. Format: YYYYDDMM_HHMMSS
Func getTrimmedTimeStamp()
   Return StringReplace(StringReplace(StringReplace(_Now(), "-", ""), ":", ""), " ", "_")
EndFunc