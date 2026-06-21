
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { /Verse.org/Colors }


# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

UIModule := class<abstract>():
    mainHUD : hud_message_device
    var theCanvas : canvas = canvas{}

    var Button1 : button_quiet = button_quiet{}
    var Button2 : button_quiet = button_quiet{}
    var Button3 : button_quiet = button_quiet{}
    var Button4 : button_quiet = button_quiet{}
    var Button5 : button_quiet = button_quiet{}
    var Button6 : button_quiet = button_quiet{}
    var ButtonExit : button_quiet = button_quiet{}

    StringToMessage<localizes>(String : string):message = "{String}"

    GetUI():canvas
    GetCanvas():canvas=
        return theCanvas
    
    ExitUI(Message:widget_message):void

    CloseUI(Player:player):void=
        Print("removing widget")
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)

MainWidget := class<abstract>(UIModule):
    var uiOpen : logic = true
    var currentSubWidget : ?NonMainWidget = false
    
NonMainWidget := class<abstract>(UIModule):
    theMainWidget : MainWidget
    bgHUD : hud_message_device

    ExitUI<override>(Message : widget_message):void=
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                bgHUD.Hide(Agent)
                mainHUD.Show(Agent)
            PlayerUI.AddWidget(theMainWidget.GetCanvas(), player_ui_slot{InputMode := ui_input_mode.All})
            set theMainWidget.currentSubWidget = false
    

SixItemWidget := class(NonMainWidget):
    Switch1 : switch_device
    Switch2 : switch_device
    Switch3 : switch_device
    Switch4 : switch_device
    Switch5 : switch_device
    Switch6 : switch_device

    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button4
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button5
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button6
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=832.0,Right:=1000.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        Button4.OnClick().Subscribe(Select4)
        Button5.OnClick().Subscribe(Select5)
        Button6.OnClick().Subscribe(Select6)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("SELECT"))
        Button2.SetText(StringToMessage("SELECT"))
        Button3.SetText(StringToMessage("SELECT"))
        Button4.SetText(StringToMessage("SELECT"))
        Button5.SetText(StringToMessage("SELECT"))
        Button6.SetText(StringToMessage("SELECT"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas

    Select1(Message : widget_message):void=
        Player := Message.Player
        Switch1.TurnOn(Player)
    Select2(Message : widget_message):void=
        Player := Message.Player
        Switch2.TurnOn(Player)
    Select3(Message : widget_message):void=
        Player := Message.Player
        Switch3.TurnOn(Player)
    Select4(Message : widget_message):void=
        Player := Message.Player
        Switch4.TurnOn(Player)
    Select5(Message : widget_message):void=
        Player := Message.Player
        Switch5.TurnOn(Player)
    Select6(Message : widget_message):void=
        Player := Message.Player
        Switch6.TurnOn(Player)

FiveItemWidget := class(NonMainWidget):
    var Switch1 : switch_device
    var Switch2 : switch_device 
    var Switch3 : switch_device
    var Switch4 : switch_device 
    var Switch5 : switch_device
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button4
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button5
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=832.0,Right:=1000.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        Button4.OnClick().Subscribe(Select4)
        Button5.OnClick().Subscribe(Select5)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("SELECT"))
        Button2.SetText(StringToMessage("SELECT"))
        Button3.SetText(StringToMessage("SELECT"))
        Button4.SetText(StringToMessage("SELECT"))
        Button5.SetText(StringToMessage("SELECT"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas

    Select1(Message : widget_message):void=
        Player := Message.Player
        Switch1.TurnOn(Player)
    Select2(Message : widget_message):void=
        Player := Message.Player
        Switch2.TurnOn(Player)
    Select3(Message : widget_message):void=
        Player := Message.Player
        Switch3.TurnOn(Player)
    Select4(Message : widget_message):void=
        Player := Message.Player
        Switch4.TurnOn(Player)
    Select5(Message : widget_message):void=
        Player := Message.Player
        Switch5.TurnOn(Player)

FourItemWidget := class(NonMainWidget):
    Switch1 : switch_device
    Switch2 : switch_device
    Switch3 : switch_device
    Switch4 : switch_device

    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=980.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button4
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=980.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=832.0,Right:=648.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        Button4.OnClick().Subscribe(Select4)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("SELECT"))
        Button2.SetText(StringToMessage("SELECT"))
        Button3.SetText(StringToMessage("SELECT"))
        Button4.SetText(StringToMessage("SELECT"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas

    Select1(Message : widget_message):void=
        Player := Message.Player
        Switch1.TurnOn(Player)
    Select2(Message : widget_message):void=
        Player := Message.Player
        Switch2.TurnOn(Player)
    Select3(Message : widget_message):void=
        Player := Message.Player
        Switch3.TurnOn(Player)
    Select4(Message : widget_message):void=
        Player := Message.Player
        Switch4.TurnOn(Player)

ThreeItemWidget := class(NonMainWidget):
    Switch1 : switch_device 
    Switch2 : switch_device
    Switch3 : switch_device 
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=580.0,Right:=1000.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("SELECT"))
        Button2.SetText(StringToMessage("SELECT"))
        Button3.SetText(StringToMessage("SELECT"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas
    
    Select1(Message : widget_message):void=
        Player := Message.Player
        Switch1.TurnOn(Player)
    Select2(Message : widget_message):void=
        Player := Message.Player
        Switch2.TurnOn(Player)
    Select3(Message : widget_message):void=
        Player := Message.Player
        Switch3.TurnOn(Player)

PrimaryWidget := class(MainWidget):
    TriggerExited : trigger_device

    #Assault Rifles
    SwitchP1 : switch_device
    SwitchP2 : switch_device
    SwitchP3 : switch_device
    SwitchP4 : switch_device 
    SwitchP5 : switch_device 
    SwitchP6 : switch_device
    arHUD : hud_message_device
    #SMGs
    SwitchP7 : switch_device 
    SwitchP8 : switch_device
    SwitchP9 : switch_device 
    SwitchP10 : switch_device 
    SwitchP11 : switch_device
    SwitchP12 : switch_device
    smgHUD : hud_message_device 
    #Shotguns
    SwitchP13 : switch_device 
    SwitchP14 : switch_device 
    SwitchP15 : switch_device 
    SwitchP16 : switch_device
    shotgunHUD : hud_message_device
    #Snipers
    SwitchP17 : switch_device 
    SwitchP18 : switch_device 
    SwitchP19 : switch_device
    SwitchP20 : switch_device
    sniperHUD : hud_message_device
    #Marksman
    SwitchP21 : switch_device
    SwitchP22 : switch_device
    SwitchP23 : switch_device
    marksmanHUD : hud_message_device

    #Make the buttons
    GetUI<override>():canvas=
        #Add buttons into the interface
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button4
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button5
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=832.0,Right:=1000.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        #Define button functions
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        Button4.OnClick().Subscribe(Select4)
        Button5.OnClick().Subscribe(Select5)
        ButtonExit.OnClick().Subscribe(ExitUI)
        #Set button text
        Button1.SetText(StringToMessage("ASSAULT"))
        Button2.SetText(StringToMessage("SMG"))
        Button3.SetText(StringToMessage("SHOTGUN"))
        Button4.SetText(StringToMessage("SNIPER"))
        Button5.SetText(StringToMessage("MARKSMAN"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas
    
    Select1(Message : widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            arHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewAssault : SixItemWidget = SixItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=arHUD
                Switch1:=SwitchP1
                Switch2:=SwitchP2
                Switch3:=SwitchP3
                Switch4:=SwitchP4
                Switch5:=SwitchP5
                Switch6:=SwitchP6
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewAssault.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewAssault]}
    Select2(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            smgHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewSMG : SixItemWidget = SixItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=smgHUD
                Switch1:=SwitchP7
                Switch2:=SwitchP8
                Switch3:=SwitchP9
                Switch4:=SwitchP10
                Switch5:=SwitchP11
                Switch6:=SwitchP12
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewSMG.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewSMG]}
    Select3(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            shotgunHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewShotgun : FourItemWidget = FourItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=shotgunHUD
                Switch1:=SwitchP13
                Switch2:=SwitchP14
                Switch3:=SwitchP15
                Switch4:=SwitchP16
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewShotgun.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewShotgun]}
    Select4(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            sniperHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewSniper : FourItemWidget = FourItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=sniperHUD
                Switch1:=SwitchP17
                Switch2:=SwitchP18
                Switch3:=SwitchP19
                Switch4:=SwitchP20
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewSniper.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewSniper]}
    Select5(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            marksmanHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewMarksman : ThreeItemWidget = ThreeItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=marksmanHUD
                Switch1:=SwitchP21
                Switch2:=SwitchP22
                Switch3:=SwitchP23
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewMarksman.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewMarksman]}
    
    ExitUI<override>(Message : widget_message):void=
        Print("Exited the PrimaryWidget!")
        set uiOpen = false
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                mainHUD.Hide(Agent)
                Print("Called primary exit trigger")
                TriggerExited.Trigger(Agent)

SecondaryWidget := class(MainWidget):
    TriggerExited : trigger_device

    #Pistols
    SwitchS1 : switch_device
    SwitchS2 : switch_device
    SwitchS3 : switch_device
    SwitchS4 : switch_device 
    SwitchS5 : switch_device 
    pistolHUD : hud_message_device
    #Explosives
    SwitchS6 : switch_device
    SwitchS7 : switch_device 
    SwitchS8 : switch_device
    explosiveHUD : hud_message_device 
    #Melee
    SwitchS9 : switch_device 
    SwitchS10 : switch_device 
    SwitchS11 : switch_device 
    meleeHUD : hud_message_device

    #Make the buttons
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=580.0,Right:=1000.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("PISTOLS"))
        Button2.SetText(StringToMessage("LAUNCHERS"))
        Button3.SetText(StringToMessage("MELEE"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas
    
    Select1(Message : widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            pistolHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewAssault : FiveItemWidget = FiveItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=pistolHUD
                Switch1:=SwitchS1
                Switch2:=SwitchS2
                Switch3:=SwitchS3
                Switch4:=SwitchS4
                Switch5:=SwitchS5
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewAssault.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewAssault]}
    Select2(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            explosiveHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewSMG : ThreeItemWidget = ThreeItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=explosiveHUD
                Switch1:=SwitchS6
                Switch2:=SwitchS7
                Switch3:=SwitchS8
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewSMG.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewSMG]}
    Select3(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            meleeHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewShotgun : ThreeItemWidget = ThreeItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=meleeHUD
                Switch1:=SwitchS9
                Switch2:=SwitchS10
                Switch3:=SwitchS11
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewShotgun.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewShotgun]}
    
    ExitUI<override>(Message : widget_message):void=
        Print("Exited the SecondaryWidget!")
        set uiOpen = false
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                mainHUD.Hide(Agent)
                Print("Called secondary exit trigger")
                TriggerExited.Trigger(Agent)

UtilityWidget := class(MainWidget):
    TriggerExited : trigger_device

    #Tactical
    SwitchT1 : switch_device
    SwitchT2 : switch_device
    SwitchT3 : switch_device
    SwitchT4 : switch_device 
    SwitchT5 : switch_device 
    SwitchT6 : switch_device
    tacticalHUD : hud_message_device
    #Lethal
    SwitchL1 : switch_device
    SwitchL2 : switch_device
    SwitchL3 : switch_device
    SwitchL4 : switch_device 
    SwitchL5 : switch_device 
    SwitchL6 : switch_device
    lethalHUD : hud_message_device

    #Make the buttons
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=980.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=580.0,Right:=648.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("TACTICAL"))
        Button2.SetText(StringToMessage("LETHAL"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas
    
    Select1(Message : widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            tacticalHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewTactical : SixItemWidget = SixItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=tacticalHUD
                Switch1:=SwitchT1
                Switch2:=SwitchT2
                Switch3:=SwitchT3
                Switch4:=SwitchT4
                Switch5:=SwitchT5
                Switch6:=SwitchT6
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewTactical.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewTactical]}
    Select2(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            lethalHUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewLethal : SixItemWidget = SixItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=lethalHUD
                Switch1:=SwitchL1
                Switch2:=SwitchL2
                Switch3:=SwitchL3
                Switch4:=SwitchL4
                Switch5:=SwitchL5
                Switch6:=SwitchL6
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewLethal.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewLethal]}
    
    ExitUI<override>(Message : widget_message):void=
        Print("Exited the UtilityWidget!")
        set uiOpen = false
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                mainHUD.Hide(Agent)
                TriggerExited.Trigger(Agent)

EquipmentWidget := class(MainWidget):
    TriggerExited : trigger_device

    #Assault Rifles
    SwitchF1 : switch_device
    SwitchF2 : switch_device
    SwitchF3 : switch_device
    SwitchF4 : switch_device

    #Make the buttons
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=980.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button4
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=980.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=832.0,Right:=648.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        Button4.OnClick().Subscribe(Select4)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("SELECT"))
        Button2.SetText(StringToMessage("SELECT"))
        Button3.SetText(StringToMessage("SELECT"))
        Button4.SetText(StringToMessage("SELECT"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas

    Select1(Message : widget_message):void=
        Player := Message.Player
        SwitchF1.TurnOn(Player)
    Select2(Message : widget_message):void=
        Player := Message.Player
        SwitchF2.TurnOn(Player)
    Select3(Message : widget_message):void=
        Player := Message.Player
        SwitchF3.TurnOn(Player)
    Select4(Message : widget_message):void=
        Player := Message.Player
        SwitchF4.TurnOn(Player)
    
    ExitUI<override>(Message : widget_message):void=
        Print("Exited the EquipmentWidget!")
        set uiOpen = false
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                mainHUD.Hide(Agent)
                TriggerExited.Trigger(Agent)

PerksWidget := class(MainWidget):
    TriggerExited : trigger_device

    #Perk 1
    SwitchPerk1A : switch_device
    SwitchPerk1B : switch_device
    SwitchPerk1C : switch_device
    perk1HUD : hud_message_device
    #Perk 2
    SwitchPerk2A : switch_device
    SwitchPerk2B : switch_device
    SwitchPerk2C : switch_device
    perk2HUD : hud_message_device

    #Make the buttons
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=980.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=632.0,Top:=580.0,Right:=648.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("1st Perk"))
        Button2.SetText(StringToMessage("2nd Perk"))
        ButtonExit.SetText(StringToMessage("BACK"))

        return theCanvas
    
    Select1(Message : widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            perk1HUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewPerk1 : ThreeItemWidget = ThreeItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=perk1HUD
                Switch1:=SwitchPerk1A
                Switch2:=SwitchPerk1B
                Switch3:=SwitchPerk1C
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewPerk1.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewPerk1]}
    Select2(Message: widget_message):void=
        Player := Message.Player
        if(Agent := agent[Player]):
            mainHUD.Hide(Agent)
            perk2HUD.Show(Agent)
        if(PlayerUI := GetPlayerUI[Player]):
            NewPerk2 : ThreeItemWidget = ThreeItemWidget{
                theMainWidget:=Self
                mainHUD:=mainHUD
                bgHUD:=perk2HUD
                Switch1:=SwitchPerk2A
                Switch2:=SwitchPerk2B
                Switch3:=SwitchPerk2C
            }
            PlayerUI.RemoveWidget(theCanvas)
            PlayerUI.AddWidget(NewPerk2.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
            set currentSubWidget = option{NonMainWidget[NewPerk2]}
    
    ExitUI<override>(Message : widget_message):void=
        Print("Exited the PerksWidget!")
        set uiOpen = false
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                mainHUD.Hide(Agent)
                TriggerExited.Trigger(Agent)

KillstreakWidget := class(MainWidget):
    TriggerExited : trigger_device

    ChooseWidgetText : text_block = text_block{}
    WhiteColor : color = color{R := 255.0, G := 255.0, B := 255.0}
    RedColor : color = color{R := 255.0, G := 0.0, B := 2.0}

    Select1Widget : texture_block
    Select2Widget : texture_block
    Select3Widget : texture_block
    Select4Widget : texture_block
    Select5Widget : texture_block
    Select6Widget : texture_block
    var numberSelected : int = 0
    var allow1 : logic = true
    var allow2 : logic = true
    var allow3 : logic = true
    var allow4 : logic = true
    var allow5 : logic = true
    var allow6 : logic = true



    #Switches
    SwitchK1 : switch_device
    SwitchK2 : switch_device
    SwitchK3 : switch_device
    SwitchK4 : switch_device
    SwitchK5 : switch_device
    SwitchK6 : switch_device
    #Make the buttons
    GetUI<override>():canvas=
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button1
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button2
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button3
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=480.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button4
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button5
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=808.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=Button6
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=1156.0,Top:=732.0,Right:=300.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ButtonExit
            Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
            Offsets:=margin{Left:=456.0,Top:=832.0,Right:=1000.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        theCanvas.AddWidget(canvas_slot:
            Widget:=ChooseWidgetText
            Anchors:=anchors{Minimum:= vector2{X:=0.5, Y:=0.0},Maximum:= vector2{X:=0.5, Y:=0.0}}
            Offsets:=margin{Left:=0.0,Top:=235.0,Right:=0.0,Bottom:=30.0}
            Alignment:=vector2{X:=0.0, Y:=0.0}
            SizeToContent:=false
            ZOrder:=1
        )
        Button1.OnClick().Subscribe(Select1)
        Button2.OnClick().Subscribe(Select2)
        Button3.OnClick().Subscribe(Select3)
        Button4.OnClick().Subscribe(Select4)
        Button5.OnClick().Subscribe(Select5)
        Button6.OnClick().Subscribe(Select6)
        ButtonExit.OnClick().Subscribe(ExitUI)
        Button1.SetText(StringToMessage("SELECT"))
        Button2.SetText(StringToMessage("SELECT"))
        Button3.SetText(StringToMessage("SELECT"))
        Button4.SetText(StringToMessage("SELECT"))
        Button5.SetText(StringToMessage("SELECT"))
        Button6.SetText(StringToMessage("SELECT"))
        ButtonExit.SetText(StringToMessage("BACK"))

        ChooseWidgetText.SetJustification(text_justification.Center)
        SetNormalText()
        

        return theCanvas
    
    SetNormalText():void=
        ChooseWidgetText.SetText(StringToMessage("Choose up to three"))
        ChooseWidgetText.SetTextColor(WhiteColor)
    SetRedText():void=
        ChooseWidgetText.SetText(StringToMessage("Maximum streaks selected"))
        ChooseWidgetText.SetTextColor(RedColor)


    CheckSelections(Agent:agent):void=
        if(SwitchK1.GetCurrentState[Agent]):
            set numberSelected += 1
            Button1.SetText(StringToMessage("SELECTED"))
            theCanvas.AddWidget(canvas_slot:
                Widget:=Select1Widget
                Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                Offsets:=margin{Left:=451.0,Top:=307.0,Right:=310.0,Bottom:=210.0}
                Alignment:=vector2{X:=0.0, Y:=0.0}
                SizeToContent:=false
                ZOrder:=1
            )
        if(SwitchK2.GetCurrentState[Agent]):
            set numberSelected += 1
            Button2.SetText(StringToMessage("SELECTED"))
            theCanvas.AddWidget(canvas_slot:
                Widget:=Select2Widget
                Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                Offsets:=margin{Left:=803.0,Top:=307.0,Right:=310.0,Bottom:=210.0}
                Alignment:=vector2{X:=0.0, Y:=0.0}
                SizeToContent:=false
                ZOrder:=1
            )
        if(SwitchK3.GetCurrentState[Agent]):
            set numberSelected += 1
            Button3.SetText(StringToMessage("SELECTED"))
            theCanvas.AddWidget(canvas_slot:
                Widget:=Select3Widget
                Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                Offsets:=margin{Left:=1151.0,Top:=307.0,Right:=310.0,Bottom:=210.0}
                Alignment:=vector2{X:=0.0, Y:=0.0}
                SizeToContent:=false
                ZOrder:=1
            )
        if(SwitchK4.GetCurrentState[Agent]):
            set numberSelected += 1
            Button4.SetText(StringToMessage("SELECTED"))
            theCanvas.AddWidget(canvas_slot:
                Widget:=Select4Widget
                Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                Offsets:=margin{Left:=451.0,Top:=557.0,Right:=310.0,Bottom:=210.0}
                Alignment:=vector2{X:=0.0, Y:=0.0}
                SizeToContent:=false
                ZOrder:=1
            )
        if(SwitchK5.GetCurrentState[Agent]):
            set numberSelected += 1
            Button5.SetText(StringToMessage("SELECTED"))
            theCanvas.AddWidget(canvas_slot:
                Widget:=Select5Widget
                Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                Offsets:=margin{Left:=803.0,Top:=557.0,Right:=310.0,Bottom:=210.0}
                Alignment:=vector2{X:=0.0, Y:=0.0}
                SizeToContent:=false
                ZOrder:=1
            )
        if(SwitchK6.GetCurrentState[Agent]):
            set numberSelected += 1
            Button6.SetText(StringToMessage("SELECTED"))
            theCanvas.AddWidget(canvas_slot:
                Widget:=Select6Widget
                Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                Offsets:=margin{Left:=1151.0,Top:=557.0,Right:=310.0,Bottom:=210.0}
                Alignment:=vector2{X:=0.0, Y:=0.0}
                SizeToContent:=false
                ZOrder:=1
            )
        if(numberSelected = 3):
            SetRedText()
            if(not SwitchK1.GetCurrentState[Agent]):
                set allow1 = false
            if(not SwitchK2.GetCurrentState[Agent]):
                set allow2 = false
            if(not SwitchK3.GetCurrentState[Agent]):
                set allow3 = false
            if(not SwitchK4.GetCurrentState[Agent]):
                set allow4 = false
            if(not SwitchK5.GetCurrentState[Agent]):
                set allow5 = false
            if(not SwitchK6.GetCurrentState[Agent]):
                set allow6 = false
    
    Select1(Message : widget_message):void=
        if(allow1 = true):
            Player := Message.Player
            if(Agent := agent[Player]):
                if(SwitchK1.GetCurrentState[Agent]):
                    set numberSelected -= 1
                    Button1.SetText(StringToMessage("SELECT"))
                    set allow2 = true
                    set allow3 = true
                    set allow4 = true
                    set allow5 = true
                    set allow6 = true
                    theCanvas.RemoveWidget(Select1Widget)
                    SetNormalText()
                else:
                    theCanvas.AddWidget(canvas_slot:
                        Widget:=Select1Widget
                        Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                        Offsets:=margin{Left:=451.0,Top:=307.0,Right:=310.0,Bottom:=210.0}
                        Alignment:=vector2{X:=0.0, Y:=0.0}
                        SizeToContent:=false
                        ZOrder:=1
                    )
                    set numberSelected += 1
                    Button1.SetText(StringToMessage("SELECTED"))
                    if(numberSelected = 3):
                        SetRedText()
                        if(not SwitchK2.GetCurrentState[Agent]):
                            set allow2 = false
                        if(not SwitchK3.GetCurrentState[Agent]):
                            set allow3 = false
                        if(not SwitchK4.GetCurrentState[Agent]):
                            set allow4 = false
                        if(not SwitchK5.GetCurrentState[Agent]):
                            set allow5 = false
                        if(not SwitchK6.GetCurrentState[Agent]):
                            set allow6 = false
                    
                SwitchK1.ToggleState(Agent)   

    Select2(Message: widget_message):void=
        if(allow2 = true):
            Player := Message.Player
            if(Agent := agent[Player]):
                if(SwitchK2.GetCurrentState[Agent]):
                    set numberSelected -= 1
                    Button2.SetText(StringToMessage("SELECT"))
                    set allow1 = true
                    set allow3 = true
                    set allow4 = true
                    set allow5 = true
                    set allow6 = true
                    theCanvas.RemoveWidget(Select2Widget)
                    SetNormalText()
                else:
                    theCanvas.AddWidget(canvas_slot:
                        Widget:=Select2Widget
                        Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                        Offsets:=margin{Left:=803.0,Top:=307.0,Right:=310.0,Bottom:=210.0}
                        Alignment:=vector2{X:=0.0, Y:=0.0}
                        SizeToContent:=false
                        ZOrder:=1
                    )
                    set numberSelected += 1
                    Button2.SetText(StringToMessage("SELECTED"))
                    if(numberSelected = 3):
                        SetRedText()
                        if(not SwitchK1.GetCurrentState[Agent]):
                            set allow1 = false
                        if(not SwitchK3.GetCurrentState[Agent]):
                            set allow3 = false
                        if(not SwitchK4.GetCurrentState[Agent]):
                            set allow4 = false
                        if(not SwitchK5.GetCurrentState[Agent]):
                            set allow5 = false
                        if(not SwitchK6.GetCurrentState[Agent]):
                            set allow6 = false
                SwitchK2.ToggleState(Agent)
                
    Select3(Message: widget_message):void=
        if(allow3 = true):
            Player := Message.Player
            if(Agent := agent[Player]):
                if(SwitchK3.GetCurrentState[Agent]):
                    set numberSelected -= 1
                    Button3.SetText(StringToMessage("SELECT"))
                    set allow1 = true
                    set allow2 = true
                    set allow4 = true
                    set allow5 = true
                    set allow6 = true
                    theCanvas.RemoveWidget(Select3Widget)
                    SetNormalText()
                else:
                    theCanvas.AddWidget(canvas_slot:
                        Widget:=Select3Widget
                        Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                        Offsets:=margin{Left:=1151.0,Top:=307.0,Right:=310.0,Bottom:=210.0}
                        Alignment:=vector2{X:=0.0, Y:=0.0}
                        SizeToContent:=false
                        ZOrder:=1
                    )
                    set numberSelected += 1
                    Button3.SetText(StringToMessage("SELECTED"))
                    if(numberSelected = 3):
                        SetRedText()
                        if(not SwitchK1.GetCurrentState[Agent]):
                            set allow1 = false
                        if(not SwitchK2.GetCurrentState[Agent]):
                            set allow2 = false
                        if(not SwitchK4.GetCurrentState[Agent]):
                            set allow4 = false
                        if(not SwitchK5.GetCurrentState[Agent]):
                            set allow5 = false
                        if(not SwitchK6.GetCurrentState[Agent]):
                            set allow6 = false
                SwitchK3.ToggleState(Agent)
                
    Select4(Message: widget_message):void=
        if(allow4 = true):
            Player := Message.Player
            if(Agent := agent[Player]):
                if(SwitchK4.GetCurrentState[Agent]):
                    set numberSelected -= 1
                    Button4.SetText(StringToMessage("SELECT"))
                    set allow1 = true
                    set allow2 = true
                    set allow3 = true
                    set allow5 = true
                    set allow6 = true
                    theCanvas.RemoveWidget(Select4Widget)
                    SetNormalText()
                else:
                    theCanvas.AddWidget(canvas_slot:
                        Widget:=Select4Widget
                        Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                        Offsets:=margin{Left:=451.0,Top:=557.0,Right:=310.0,Bottom:=210.0}
                        Alignment:=vector2{X:=0.0, Y:=0.0}
                        SizeToContent:=false
                        ZOrder:=1
                    )
                    set numberSelected += 1
                    Button4.SetText(StringToMessage("SELECTED"))
                    if(numberSelected = 3):
                        SetRedText()
                        if(not SwitchK1.GetCurrentState[Agent]):
                            set allow1 = false
                        if(not SwitchK2.GetCurrentState[Agent]):
                            set allow2 = false
                        if(not SwitchK3.GetCurrentState[Agent]):
                            set allow3 = false
                        if(not SwitchK5.GetCurrentState[Agent]):
                            set allow5 = false
                        if(not SwitchK6.GetCurrentState[Agent]):
                            set allow6 = false
                SwitchK4.ToggleState(Agent)
    
    Select5(Message: widget_message):void=
        if(allow5 = true):
            Player := Message.Player
            if(Agent := agent[Player]):
                if(SwitchK5.GetCurrentState[Agent]):
                    set numberSelected -= 1
                    Button5.SetText(StringToMessage("SELECT"))
                    set allow1 = true
                    set allow2 = true
                    set allow3 = true
                    set allow4 = true
                    set allow6 = true
                    theCanvas.RemoveWidget(Select5Widget)
                    SetNormalText()
                else:
                    theCanvas.AddWidget(canvas_slot:
                        Widget:=Select5Widget
                        Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                        Offsets:=margin{Left:=803.0,Top:=557.0,Right:=310.0,Bottom:=210.0}
                        Alignment:=vector2{X:=0.0, Y:=0.0}
                        SizeToContent:=false
                        ZOrder:=1
                    )
                    set numberSelected += 1
                    Button5.SetText(StringToMessage("SELECTED"))
                    if(numberSelected = 3):
                        SetRedText()
                        if(not SwitchK1.GetCurrentState[Agent]):
                            set allow1 = false
                        if(not SwitchK2.GetCurrentState[Agent]):
                            set allow2 = false
                        if(not SwitchK3.GetCurrentState[Agent]):
                            set allow3 = false
                        if(not SwitchK4.GetCurrentState[Agent]):
                            set allow4 = false
                        if(not SwitchK6.GetCurrentState[Agent]):
                            set allow6 = false
                SwitchK5.ToggleState(Agent)
            
                
    Select6(Message: widget_message):void=
        if(allow6 = true):
            Player := Message.Player
            if(Agent := agent[Player]):
                if(SwitchK6.GetCurrentState[Agent]):
                    set numberSelected -= 1
                    Button6.SetText(StringToMessage("SELECT"))
                    set allow1 = true
                    set allow2 = true
                    set allow3 = true
                    set allow4 = true
                    set allow5 = true
                    theCanvas.RemoveWidget(Select6Widget)
                    SetNormalText()
                    
                else:
                    theCanvas.AddWidget(canvas_slot:
                        Widget:=Select6Widget
                        Anchors:=anchors{Minimum:= vector2{X:=0.0, Y:=0.0},Maximum:= vector2{X:=0.0, Y:=0.0}}
                        Offsets:=margin{Left:=1151.0,Top:=557.0,Right:=310.0,Bottom:=210.0}
                        Alignment:=vector2{X:=0.0, Y:=0.0}
                        SizeToContent:=false
                        ZOrder:=1
                    )
                    set numberSelected += 1
                    Button6.SetText(StringToMessage("SELECTED"))
                    if(numberSelected = 3):
                        SetRedText()
                        if(not SwitchK1.GetCurrentState[Agent]):
                            set allow1 = false
                        if(not SwitchK2.GetCurrentState[Agent]):
                            set allow2 = false
                        if(not SwitchK3.GetCurrentState[Agent]):
                            set allow3 = false
                        if(not SwitchK4.GetCurrentState[Agent]):
                            set allow4 = false
                        if(not SwitchK5.GetCurrentState[Agent]):
                            set allow5 = false
                SwitchK6.ToggleState(Agent)
                
    
    ExitUI<override>(Message : widget_message):void=
        Print("Exited the KillstreakWidget!")
        set uiOpen = false
        Player := Message.Player
        if(PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(theCanvas)
            if(Agent := agent[Player]):
                mainHUD.Hide(Agent)
                TriggerExited.Trigger(Agent)

LoadoutUI_device := class(creative_device):
    #Open UI Buttons
    @editable primaryButton : button_device = button_device{}
    @editable secondaryButton : button_device = button_device{}
    @editable utilityButton : button_device = button_device{}
    @editable equipmentButton : button_device = button_device{}
    @editable perkButton : button_device = button_device{}
    @editable killstreakButton : button_device = button_device{}

    @editable ExitedUI : trigger_device = trigger_device{}

    #System Management
    @editable preroundEndTrigger : trigger_device = trigger_device{}
    var playerList : [player]MainWidget = map{}
    GreenTexture : texture = pregame.greenSelection
    var Green1 : ?texture_block = false
    var Green2 : ?texture_block = false
    var Green3 : ?texture_block = false
    var Green4 : ?texture_block = false
    var Green5 : ?texture_block = false
    var Green6 : ?texture_block = false


    #Primary Switches and HUDs
    @editable SwitchP1 : switch_device = switch_device{}
    @editable SwitchP2 : switch_device = switch_device{}
    @editable SwitchP3 : switch_device = switch_device{}
    @editable SwitchP4 : switch_device = switch_device{}
    @editable SwitchP5 : switch_device = switch_device{}
    @editable SwitchP6 : switch_device = switch_device{}
    @editable SwitchP7 : switch_device = switch_device{}
    @editable SwitchP8 : switch_device = switch_device{}
    @editable SwitchP9 : switch_device = switch_device{}
    @editable SwitchP10 : switch_device = switch_device{}
    @editable SwitchP11 : switch_device = switch_device{}
    @editable SwitchP12 : switch_device = switch_device{}
    @editable SwitchP13 : switch_device = switch_device{}
    @editable SwitchP14 : switch_device = switch_device{}
    @editable SwitchP15 : switch_device = switch_device{}
    @editable SwitchP16 : switch_device = switch_device{}
    @editable SwitchP17 : switch_device = switch_device{}
    @editable SwitchP18 : switch_device = switch_device{}
    @editable SwitchP19 : switch_device = switch_device{}
    @editable SwitchP20 : switch_device = switch_device{}
    @editable SwitchP21 : switch_device = switch_device{}
    @editable SwitchP22 : switch_device = switch_device{}
    @editable SwitchP23 : switch_device = switch_device{}
    @editable primaryHUD : hud_message_device = hud_message_device{}
    @editable arHUD : hud_message_device = hud_message_device{}
    @editable smgHUD : hud_message_device = hud_message_device{}
    @editable shotgunHUD : hud_message_device = hud_message_device{}
    @editable sniperHUD : hud_message_device = hud_message_device{}
    @editable marksmanHUD : hud_message_device = hud_message_device{}    
    #Secondary Switches and HUDs
    @editable SwitchS1 : switch_device = switch_device{}
    @editable SwitchS2 : switch_device = switch_device{}
    @editable SwitchS3 : switch_device = switch_device{}
    @editable SwitchS4 : switch_device = switch_device{}
    @editable SwitchS5 : switch_device = switch_device{}
    @editable SwitchS6 : switch_device = switch_device{}
    @editable SwitchS7 : switch_device = switch_device{}
    @editable SwitchS8 : switch_device = switch_device{}
    @editable SwitchS9 : switch_device = switch_device{}
    @editable SwitchS10 : switch_device = switch_device{}
    @editable SwitchS11 : switch_device = switch_device{}
    @editable secondaryHUD : hud_message_device = hud_message_device{}
    @editable pistolHUD : hud_message_device = hud_message_device{}
    @editable explosiveHUD : hud_message_device = hud_message_device{}
    @editable meleeHUD : hud_message_device = hud_message_device{}
    #Utility Switches
    @editable SwitchT1 : switch_device = switch_device{}
    @editable SwitchT2 : switch_device = switch_device{}
    @editable SwitchT3 : switch_device = switch_device{}
    @editable SwitchT4 : switch_device = switch_device{}
    @editable SwitchT5 : switch_device = switch_device{}
    @editable SwitchT6 : switch_device = switch_device{}
    @editable SwitchL1 : switch_device = switch_device{}
    @editable SwitchL2 : switch_device = switch_device{}
    @editable SwitchL3 : switch_device = switch_device{}
    @editable SwitchL4 : switch_device = switch_device{}
    @editable SwitchL5 : switch_device = switch_device{}
    @editable SwitchL6 : switch_device = switch_device{}
    @editable utilityHUD : hud_message_device = hud_message_device{}
    @editable tacticalHUD : hud_message_device = hud_message_device{}
    @editable lethalHUD : hud_message_device = hud_message_device{}
    #Equipment Switches
    @editable SwitchF1 : switch_device = switch_device{}
    @editable SwitchF2 : switch_device = switch_device{}
    @editable SwitchF3 : switch_device = switch_device{}
    @editable SwitchF4 : switch_device = switch_device{}
    @editable equipmentHUD : hud_message_device = hud_message_device{}
    #Perk Switches
    @editable SwitchPerk1A : switch_device = switch_device{}
    @editable SwitchPerk1B : switch_device = switch_device{}
    @editable SwitchPerk1C : switch_device = switch_device{}
    @editable SwitchPerk2A : switch_device = switch_device{}
    @editable SwitchPerk2B : switch_device = switch_device{}
    @editable SwitchPerk2C : switch_device = switch_device{}
    @editable perkHUD : hud_message_device = hud_message_device{}
    @editable perk1HUD : hud_message_device = hud_message_device{}
    @editable perk2HUD : hud_message_device = hud_message_device{}
    #Killstreak Switches
    @editable SwitchK1 : switch_device = switch_device{}
    @editable SwitchK2 : switch_device = switch_device{}
    @editable SwitchK3 : switch_device = switch_device{}
    @editable SwitchK4 : switch_device = switch_device{}
    @editable SwitchK5 : switch_device = switch_device{}
    @editable SwitchK6 : switch_device = switch_device{}
    @editable killstreakHUD : hud_message_device = hud_message_device{}

    @editable MythicUpgradeInput : input_trigger_device = input_trigger_device{}
    @editable mythicP1 : item_granter_device = item_granter_device{}
    @editable mythicP3 : item_granter_device = item_granter_device{}
    @editable mythicP4 : item_granter_device = item_granter_device{}
    @editable mythicP5 : item_granter_device = item_granter_device{}
    @editable mythicP6 : item_granter_device = item_granter_device{}
    @editable mythicP7 : item_granter_device = item_granter_device{}
    @editable mythicP8 : item_granter_device = item_granter_device{}
    @editable mythicP10 : item_granter_device = item_granter_device{}
    @editable mythicP12 : item_granter_device = item_granter_device{}
    @editable mythicP13 : item_granter_device = item_granter_device{}
    @editable mythicP14 : item_granter_device = item_granter_device{}
    @editable mythicP16 : item_granter_device = item_granter_device{}
    @editable mythicP18 : item_granter_device = item_granter_device{}
    @editable mythicP21 : item_granter_device = item_granter_device{}
    @editable mythicP22 : item_granter_device = item_granter_device{}
    @editable mythicP23 : item_granter_device = item_granter_device{}
    @editable mythicS2 : item_granter_device = item_granter_device{}
    @editable mythicS4 : item_granter_device = item_granter_device{}
    @editable mythicS5 : item_granter_device = item_granter_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        set Green1 = option{texture_block{ DefaultImage := GreenTexture, DefaultDesiredSize := vector2{ X := 300.0, Y := 200.0}}}
        set Green2 = option{texture_block{ DefaultImage := GreenTexture, DefaultDesiredSize := vector2{ X := 300.0, Y := 200.0}}}
        set Green3 = option{texture_block{ DefaultImage := GreenTexture, DefaultDesiredSize := vector2{ X := 300.0, Y := 200.0}}}
        set Green4 = option{texture_block{ DefaultImage := GreenTexture, DefaultDesiredSize := vector2{ X := 300.0, Y := 200.0}}}
        set Green5 = option{texture_block{ DefaultImage := GreenTexture, DefaultDesiredSize := vector2{ X := 300.0, Y := 200.0}}}
        set Green6 = option{texture_block{ DefaultImage := GreenTexture, DefaultDesiredSize := vector2{ X := 300.0, Y := 200.0}}}

        primaryButton.InteractedWithEvent.Subscribe(OpenPrimary)
        secondaryButton.InteractedWithEvent.Subscribe(OpenSecondary)
        utilityButton.InteractedWithEvent.Subscribe(OpenUtility)
        equipmentButton.InteractedWithEvent.Subscribe(OpenEquipment)
        perkButton.InteractedWithEvent.Subscribe(OpenPerks)
        killstreakButton.InteractedWithEvent.Subscribe(OpenKillstreaks)

        MythicUpgradeInput.PressedEvent.Subscribe(UpgradeToMythics)

        ExitedUI.TriggeredEvent.Subscribe(ResetOpenWidget)
        preroundEndTrigger.TriggeredEvent.Subscribe(CloseAllWidgets)

    CloseAllWidgets(Agent:?agent):void=
        Print("closing all")
        for(aPlayer->playerUI : playerList):
            Print("there is something in the for loop")
            if(subUI := playerUI.currentSubWidget?):
                subUI.CloseUI(aPlayer)
                Print("closing sub ui")
            else:
                playerUI.CloseUI(aPlayer)
                Print("closing main ui")
            Print("Trasmitting to state channel")
            if(anAgent := agent[aPlayer]):
                ExitedUI.Trigger(anAgent)
    
    ResetOpenWidget(Agent:?agent):void=
        if(Player := player[Agent?]):
            set playerList = RemoveFromMap(playerList,Player)
    
    RemoveFromMap(Map:[player]MainWidget,Player:player):[player]MainWidget=
        var tempList : [player]MainWidget = map{}
        for(aPlayer->playerUI : playerList):
            if(aPlayer <> Player):
                if(set tempList[aPlayer] = playerUI):
        return tempList
    

    OpenPrimary(Agent:agent):void=
        if(Player := player[Agent]):
            if(PlayerUI := GetPlayerUI[Player]):
                NewPrimary : PrimaryWidget = PrimaryWidget{
                    mainHUD:=primaryHUD
                    TriggerExited:=ExitedUI
                    arHUD := arHUD
                    smgHUD := smgHUD
                    shotgunHUD := shotgunHUD
                    sniperHUD := sniperHUD
                    marksmanHUD := marksmanHUD
                    SwitchP1:=SwitchP1
                    SwitchP2:=SwitchP2
                    SwitchP3:=SwitchP3
                    SwitchP4:=SwitchP4
                    SwitchP5:=SwitchP5
                    SwitchP6:=SwitchP6
                    SwitchP7:=SwitchP7
                    SwitchP8:=SwitchP8
                    SwitchP9:=SwitchP9
                    SwitchP10:=SwitchP10
                    SwitchP11:=SwitchP11
                    SwitchP12:=SwitchP12
                    SwitchP13:=SwitchP13
                    SwitchP14:=SwitchP14
                    SwitchP15:=SwitchP15
                    SwitchP16:=SwitchP16
                    SwitchP17:=SwitchP17
                    SwitchP18:=SwitchP18
                    SwitchP19:=SwitchP19
                    SwitchP20:=SwitchP20
                    SwitchP21:=SwitchP21
                    SwitchP22:=SwitchP22
                    SwitchP23:=SwitchP23
                }
                PlayerUI.AddWidget(NewPrimary.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
                if(set playerList[Player] = NewPrimary):

    OpenSecondary(Agent:agent):void=
        if(Player := player[Agent]):
            if(PlayerUI := GetPlayerUI[Player]):
                    NewSecondary : SecondaryWidget = SecondaryWidget{
                    mainHUD:=secondaryHUD
                    TriggerExited:=ExitedUI
                    pistolHUD:=pistolHUD
                    explosiveHUD:=explosiveHUD
                    meleeHUD:=meleeHUD
                    SwitchS1:=SwitchS1
                    SwitchS2:=SwitchS2
                    SwitchS3:=SwitchS3
                    SwitchS4:=SwitchS4
                    SwitchS5:=SwitchS5
                    SwitchS6:=SwitchS6
                    SwitchS7:=SwitchS7
                    SwitchS8:=SwitchS8
                    SwitchS9:=SwitchS9
                    SwitchS10:=SwitchS10
                    SwitchS11:=SwitchS11
                }
                PlayerUI.AddWidget(NewSecondary.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
                if(set playerList[Player] = NewSecondary):
    
    OpenUtility(Agent:agent):void=
        if(Player := player[Agent]):
            if(PlayerUI := GetPlayerUI[Player]):
                NewUtility : UtilityWidget = UtilityWidget{
                    mainHUD:=utilityHUD
                    TriggerExited:=ExitedUI
                    tacticalHUD:=tacticalHUD
                    lethalHUD:=lethalHUD
                    SwitchT1 := SwitchT1
                    SwitchT2 := SwitchT2
                    SwitchT3 := SwitchT3
                    SwitchT4 := SwitchT4
                    SwitchT5 := SwitchT5
                    SwitchT6 := SwitchT6
                    SwitchL1 := SwitchL1
                    SwitchL2 := SwitchL2
                    SwitchL3 := SwitchL3
                    SwitchL4 := SwitchL4
                    SwitchL5 := SwitchL5
                    SwitchL6 := SwitchL6   
                }
                PlayerUI.AddWidget(NewUtility.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
                if(set playerList[Player] = NewUtility):
    OpenEquipment(Agent:agent):void=
        if(Player := player[Agent]):
            if(PlayerUI := GetPlayerUI[Player]):
                NewEquipment : EquipmentWidget = EquipmentWidget{
                    mainHUD:=equipmentHUD
                    TriggerExited:=ExitedUI
                    SwitchF1:=SwitchF1
                    SwitchF2:=SwitchF2
                    SwitchF3:=SwitchF3
                    SwitchF4:=SwitchF4
                }
                PlayerUI.AddWidget(NewEquipment.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
                if(set playerList[Player] = NewEquipment):
    OpenPerks(Agent:agent):void=
        if(Player := player[Agent]):
            if(PlayerUI := GetPlayerUI[Player]):
                NewPerks : PerksWidget = PerksWidget{
                    mainHUD:=perkHUD
                    TriggerExited:=ExitedUI
                    SwitchPerk1A:=SwitchPerk1A
                    SwitchPerk1B:=SwitchPerk1B
                    SwitchPerk1C:=SwitchPerk1C
                    SwitchPerk2A:=SwitchPerk2A
                    SwitchPerk2B:=SwitchPerk2B
                    SwitchPerk2C:=SwitchPerk2C
                    perk1HUD:=perk1HUD
                    perk2HUD:=perk2HUD
                }
                PlayerUI.AddWidget(NewPerks.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
                if(set playerList[Player] = NewPerks):
    OpenKillstreaks(Agent:agent):void=
        if(Player := player[Agent]):
            if(PlayerUI := GetPlayerUI[Player]):
                if(aGreen1 := Green1?):
                    if(aGreen2 := Green2?):
                        if(aGreen3 := Green3?):
                            if(aGreen4 := Green4?):
                                if(aGreen5 := Green5?):
                                    if(aGreen6 := Green6?):
                                        NewKillstreaks : KillstreakWidget = KillstreakWidget{
                                            mainHUD:=killstreakHUD
                                            TriggerExited:=ExitedUI
                                            Select1Widget:=aGreen1
                                            Select2Widget:=aGreen2
                                            Select3Widget:=aGreen3
                                            Select4Widget:=aGreen4
                                            Select5Widget:=aGreen5
                                            Select6Widget:=aGreen6
                                            SwitchK1:=SwitchK1
                                            SwitchK2:=SwitchK2
                                            SwitchK3:=SwitchK3
                                            SwitchK4:=SwitchK4
                                            SwitchK5:=SwitchK5
                                            SwitchK6:=SwitchK6

                                        }
                                        PlayerUI.AddWidget(NewKillstreaks.GetUI(), player_ui_slot{InputMode := ui_input_mode.All})
                                        NewKillstreaks.CheckSelections(Agent)
                                        if(set playerList[Player] = NewKillstreaks):
    
    UpgradeToMythics(Agent:agent):void=
        Print("Upgrade Called!")
        if(SwitchP1.GetCurrentState[Agent]):
            Print("Give Mythic Holo")
            mythicP1.GrantItem(Agent)
        else if(SwitchP3.GetCurrentState[Agent]):
            mythicP3.GrantItem(Agent)
        else if(SwitchP4.GetCurrentState[Agent]):
            mythicP4.GrantItem(Agent)
        else if(SwitchP5.GetCurrentState[Agent]):
            mythicP5.GrantItem(Agent)
        else if(SwitchP6.GetCurrentState[Agent]):
            mythicP6.GrantItem(Agent)
        else if(SwitchP7.GetCurrentState[Agent]):
            mythicP7.GrantItem(Agent)
        else if(SwitchP8.GetCurrentState[Agent]):
            mythicP8.GrantItem(Agent)
        else if(SwitchP10.GetCurrentState[Agent]):
            mythicP10.GrantItem(Agent)
        else if(SwitchP12.GetCurrentState[Agent]):
            mythicP12.GrantItem(Agent)
        else if(SwitchP13.GetCurrentState[Agent]):
            mythicP13.GrantItem(Agent)
        else if(SwitchP14.GetCurrentState[Agent]):
            mythicP14.GrantItem(Agent)
        else if(SwitchP16.GetCurrentState[Agent]):
            mythicP16.GrantItem(Agent)
        else if(SwitchP18.GetCurrentState[Agent]):
            mythicP18.GrantItem(Agent)
        else if(SwitchP21.GetCurrentState[Agent]):
            mythicP21.GrantItem(Agent)
        else if(SwitchP22.GetCurrentState[Agent]):
            mythicP22.GrantItem(Agent)
        else if(SwitchP23.GetCurrentState[Agent]):
            mythicP23.GrantItem(Agent)
        if(SwitchS2.GetCurrentState[Agent]):
            mythicS2.GrantItem(Agent)
        else if(SwitchS4.GetCurrentState[Agent]):
            mythicS4.GrantItem(Agent)
        else if(SwitchS5.GetCurrentState[Agent]):
            mythicS5.GrantItem(Agent)