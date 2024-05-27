#Requires AutoHotkey v2.0
#SingleInstance Force

;icon
TraySetIcon "the cheshire cat is on the desktop - icon 256 rect.ico"



;search hidden windows
DetectHiddenWindows true

;Send a system notification using the Windows balloon tips.
;TrayTip "window interactions:`nshow or hide the window by pressing [INS]`ncycling between frames by pressing [F2]", "The Cheshire cat is on the desktop"
TrayTip "-The cat always appears where it is needed-`nshow or hide the window by pressing [INS]`ncycling frames by pressing [F2] - reset [F3]", "The Cheshire cat is on the desktop" , "48"
SetTimer () => TrayTip(), -5000

;Create a shortcut in the Windows Startup folder  
FileCreateShortcut A_WorkingDir "\the cheshire cat is on the desktop.ahk", A_Startup "\the cheshire cat is on the desktop.lnk", A_WorkingDir, A_ScriptFullPath, "My Description", A_WorkingDir "\the cheshire cat is on the desktop - icon 256 rect.ico"





;---- browser ----------------------------------------
;use detect hidden windows
if not WinExist("Cheshire Cat - Iron")
{
    ;set browser path
    Run "browser_folder\IronPortable\IronPortable.exe"
    
    sleep 2000
    WinWait("Cheshire Cat - Iron")
}

WinActivate ("Cheshire Cat - Iron")

;HWND
global active_id := WinGetID("Cheshire Cat - Iron")

;set style
WinSetStyle "-0xCF0000" , "ahk_id " active_id  ;WS_OVERLAPPEDWINDOW



;finestra dinamica
;si adatta in base all'altezza dello schermo
;A_ScreenWidth
;A_ScreenHeight

global int_gui_x
int_gui_x := A_ScreenWidth - 516 -10

;int_gui_y := 
;int_gui_w := 

global int_gui_h
int_gui_h := A_ScreenHeight -100

;set position and size dinamically
;WinMove 1403, 0, 516, 1031, "ahk_id " active_id
WinMove int_gui_x, 0, 516, int_gui_h, "ahk_id " active_id

global int_gui_h2

int_gui_h2 := int_gui_h - 5


;set window style
WinSetRegion "13-90 49-105 200-90 300-90 438-102 507-91 506-108 500-139 508-167 507-3020 502-3025 15-3025 10-3020 10-161 22-137 " , "ahk_id " active_id


;set window as AlwaysOnTop of the stack
WinSetAlwaysOnTop 1, "ahk_id " active_id

;hide window
;WinHide "ahk_id " active_id
WinShow "ahk_id " active_id

;set global variables
global bln_show
 bln_show := 1

global bln_frame
 bln_frame := 1


;Show or hide only when the window is active.
HotIfWinActive "ahk_id " active_id 
 Hotkey "F2"  , fn_gui_toggle_frame
 Hotkey "F3"  , fn_gui_reset_style
HotIfWinActive


return
;--------------------------------
;--------------------------------


;--- HOTKEY ---------------------
; [CTRL] + [INS]
^Ins::
{
    ;local variable
    bln_A := bln_frame

 if (bln_A = 0) {
    WinShow "ahk_id " active_id
    sleep 400
	WinActivate "ahk_id " active_id  
    bln_A := 1
 }
 else if (bln_A = 1) {    
    WinHide "ahk_id " active_id
    sleep 400
    send "^{Tab}"    
    bln_A := 0
 }
    
    ;set global variable
    global bln_frame := bln_A

}


;---------------------------------------
fn_gui_toggle_frame(HotkeyName)
{
    ;local variable
    bln_A := bln_show

  if (bln_A = 0) {
    ;cat silouette
    WinSetRegion "13-90 49-105 200-90 300-90 438-102 507-91 506-108 500-139 508-167 507-3020 502-3025 15-3025 10-3020 10-161 22-137 " , "ahk_id " active_id
    bln_A := 1
  }
  else if (bln_A = 1) {
    ;  rettangolo
    WinSetRegion "10-90 508-90 508-3025 10-3025 " , "ahk_id " active_id   
    
    bln_A := 2
  }
  else if (bln_A = 2) {
    ;  rettangolo
    WinSetRegion "10-95 15-90 503-90 508-95 508-3020 503-3025 15-3025 10-3020 " , "ahk_id " active_id   
    
    bln_A := 3
  } 
  else if (bln_A = 3) {
    ; with the top bar
    WinSetRegion "10-2 508-2 508-3025 10-3025 " , "ahk_id " active_id    
    bln_A := 4
  } 

  else if (bln_A = 4) {
    ; reset
    WinSetRegion , "ahk_id " active_id
    bln_A := 0
  } 
    ;set global variable
    global bln_show := bln_A
}



fn_gui_reset_style(HotkeyName) 
{
  ;set style
  WinSetStyle "-0xCF0000" , "ahk_id " active_id  ;WS_OVERLAPPEDWINDOW

  ;set position and size
  ;WinMove 1403, 0, 516, 1031, "ahk_id " active_id
  WinMove int_gui_x, 0, 516, int_gui_h, "ahk_id " active_id

  ;set window style
  WinSetRegion "13-90 49-105 200-90 300-90 438-102 507-91 506-108 500-139 508-167 507-1020 502-1025 15-1025 10-1020 10-161 22-137 " , "ahk_id " active_id

  ;set window as AlwaysOnTop of the stack
  WinSetAlwaysOnTop 1, "ahk_id " active_id

  ;hide window
  ;WinHide "ahk_id " active_id
  WinShow "ahk_id " active_id

}



