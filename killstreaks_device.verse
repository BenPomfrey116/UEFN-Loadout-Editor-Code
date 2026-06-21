
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }


PlayerDetails := class():
    Agent : agent
    Input1 : input_trigger_device
    Input2 : input_trigger_device
    Input3 : input_trigger_device
    Input4 : input_trigger_device
    Input5 : input_trigger_device
    Input6 : input_trigger_device
    Switch1 : switch_device
    Switch2 : switch_device
    Switch3 : switch_device
    Switch4 : switch_device
    Switch5 : switch_device
    Switch6 : switch_device

    var lower : int = 0

    var selected1 : logic = false
    var selected2 : logic = false
    var selected3 : logic = false
    var selected4 : logic = false
    var selected5 : logic = false
    var selected6 : logic = false

    var has1 : logic = false
    var has2 : logic = false
    var has3 : logic = false
    var has4 : logic = false
    var has5 : logic = false
    var has6 : logic = false
    var currentStreak : int = 0


    incrementStreak():void=
        set currentStreak += 1
        Print("New Streak: "+ToString(currentStreak)+", Lower: "+ToString(lower))
        if(currentStreak = 4+lower and Switch1.GetCurrentState[Agent]):
            Print("Registering 1")
            Input1.Register(Agent)
            set has1 = true
        if(currentStreak = 5+lower and Switch2.GetCurrentState[Agent]):
            Print("Registering 2")
            Input2.Register(Agent)
            set has2 = true
            Input1.Unregister(Agent)
        if(currentStreak = 7+lower and Switch3.GetCurrentState[Agent]):
            Print("Registering 3")
            Input3.Register(Agent)
            set has3 = true
            Input1.Unregister(Agent)
            Input2.Unregister(Agent)
        if(currentStreak = 10+lower and Switch4.GetCurrentState[Agent]):
            Input4.Register(Agent)
            set has4 = true
            Input1.Unregister(Agent)
            Input2.Unregister(Agent)
            Input3.Unregister(Agent)
        if(currentStreak = 12+lower and Switch5.GetCurrentState[Agent]):
            Input5.Register(Agent)
            set has5 = true
            Input1.Unregister(Agent)
            Input2.Unregister(Agent)
            Input3.Unregister(Agent)
        if(currentStreak = 15+lower and Switch6.GetCurrentState[Agent]):
            Input6.Register(Agent)
            set has6 = true
            Input1.Unregister(Agent)
            Input2.Unregister(Agent)
            Input3.Unregister(Agent)
            Input4.Unregister(Agent)
            Input5.Unregister(Agent)


    resetStreak():void=
        set currentStreak = 0


killstreaks_device := class(creative_device):
    @editable SpawnChannel : channel_device = channel_device{}
    @editable ElimManager : elimination_manager_device = elimination_manager_device{}
    @editable ElimDeathManager : elimination_manager_device = elimination_manager_device{}
    @editable LowerToggle : trigger_device = trigger_device{}
    @editable LowerSwitch : switch_device = switch_device{}

    @editable InputK1 : input_trigger_device = input_trigger_device{}
    @editable InputK2 : input_trigger_device = input_trigger_device{}
    @editable InputK3 : input_trigger_device = input_trigger_device{}
    @editable InputK4 : input_trigger_device = input_trigger_device{}
    @editable InputK5 : input_trigger_device = input_trigger_device{}
    @editable InputK6 : input_trigger_device = input_trigger_device{}

    @editable SwitchK1 : switch_device = switch_device{}
    @editable SwitchK2 : switch_device = switch_device{}
    @editable SwitchK3 : switch_device = switch_device{}
    @editable SwitchK4 : switch_device = switch_device{}
    @editable SwitchK5 : switch_device = switch_device{}
    @editable SwitchK6 : switch_device = switch_device{}

    #K3 - Guided Missile
    @editable ConditionalMissile : conditional_button_device = conditional_button_device{}
    @editable MissileInput : input_trigger_device = input_trigger_device{}
    @editable UseMissileTimer : timer_device = timer_device{}

    #K5 - Stealth Agent
    @editable StealthTimer : timer_device = timer_device{}
    

    
    var playerList : [agent]PlayerDetails = map{}
    var agentList : []agent = array{}



    OnBegin<override>()<suspends>:void=
        AllPlayers : []player = GetPlayspace().GetPlayers()
        for(Player : AllPlayers):
            if(Agent := agent[Player]):
                NewDetails : PlayerDetails = PlayerDetails{
                        Agent:=Agent
                        Input1:=InputK1
                        Input2:=InputK2
                        Input3:=InputK3
                        Input4:=InputK4
                        Input5:=InputK5
                        Input6:=InputK6
                        Switch1:=SwitchK1
                        Switch2:=SwitchK2
                        Switch3:=SwitchK3
                        Switch4:=SwitchK4
                        Switch5:=SwitchK5
                        Switch6:=SwitchK6
                    }
                if(LowerSwitch.GetCurrentState[Agent]):
                    set NewDetails.lower = -1
                if(set playerList[Agent] = NewDetails):
                set agentList += array{Agent}
        for(anAgent->aDetails : playerList):
            Print("Player in list")
        ElimManager.EliminationEvent.Subscribe(Elim)
        LowerToggle.TriggeredEvent.Subscribe(ToggleLower)
        ElimDeathManager.EliminatedEvent.Subscribe(AgentDie)
        InputK1.PressedEvent.Subscribe(UsedK1)
        InputK2.PressedEvent.Subscribe(UsedK2)
        InputK3.PressedEvent.Subscribe(UsedK3)
        InputK4.PressedEvent.Subscribe(UsedK4)
        InputK5.PressedEvent.Subscribe(UsedK5)
        InputK6.PressedEvent.Subscribe(UsedK6)
        MissileInput.PressedEvent.Subscribe(UsedMissile)
        StealthTimer.SuccessEvent.Subscribe(StealthEnd)


                



    Elim(Agent:?agent):void=
        Print("Called Elim")
        if(theAgent := Agent?):
            if(theDetails := playerList[theAgent]):
                theDetails.incrementStreak()

    ToggleLower(tempAgent:?agent):void=
        if(Agent := tempAgent?):
            if(playerList[Agent].lower = 0):
                if(set playerList[Agent].lower = -1):
            else:
                if(set playerList[Agent].lower = 0):

    AgentDie(Agent:agent):void=
        ResetPlayer(Agent)
        if(playerList[Agent].resetStreak):


    UsedK1(Agent:agent):void=
        Print("Used1")
        InputK1.Unregister(Agent)
        if(set playerList[Agent].has1 = false):
        if(FortCharacter := player[Agent].GetFortCharacter[]):
            FortCharacter.SetMaxShield(50.0)
            FortCharacter.SetShield(50.0)
    UsedK2(Agent:agent):void=
        Print("Used2")
        InputK2.Unregister(Agent)
        if(set playerList[Agent].has2 = false):
        GiveInputTrigger(Agent)
    UsedK3(Agent:agent):void=
        Print("Used3")
        InputK3.Unregister(Agent)
        MissileInput.Register(Agent)
    UsedK4(Agent:agent):void=
        Print("Used4")
        InputK4.Unregister(Agent)
        if(set playerList[Agent].has4 = false):
        GiveInputTrigger(Agent)
    UsedK5(Agent:agent):void=
        Print("Used5")
        InputK5.Unregister(Agent)
        if(set playerList[Agent].has5 = false):
        if(FortCharacter := player[Agent].GetFortCharacter[]):
            FortCharacter.Hide()
        GiveInputTrigger(Agent)
    UsedK6(Agent:agent):void=
        Print("Used6")
        InputK6.Unregister(Agent)
        if(set playerList[Agent].has6 = false):
        GiveInputTrigger(Agent)

    UsedMissile(Agent:agent):void=
        Print("Used Missile!!!")
        if(ConditionalMissile.IsHoldingItem[Agent]):
            if(playerList[Agent].has3 = true):
                Print("Holding Guided Missile After Input Press!")
                if(set playerList[Agent].has3 = false):
                GiveInputTrigger(Agent)
                UseMissileTimer.Start(Agent)
            else:
                UseMissileTimer.Complete(Agent)
    
    StealthEnd(tempAgent:?agent):void=
        if(Agent := tempAgent?):
            if(FortCharacter := player[Agent].GetFortCharacter[]):
                FortCharacter.Show()

    GiveInputTrigger(Agent:agent):void=
        if(playerList[Agent].has6 = true):
            Print("Registered 6!")
            InputK6.Register(Agent)
        if(playerList[Agent].has5 = true):
            Print("Registered 5!")
            InputK5.Register(Agent)
        if(playerList[Agent].has4 = true):
            Print("Registered 4!")
            InputK4.Register(Agent)
        if(playerList[Agent].has3 = true):
            Print("Registered 3!")
            InputK3.Register(Agent)
        if(playerList[Agent].has2 = true):
            Print("Registered 2!")
            InputK2.Register(Agent)
        if(playerList[Agent].has1 = true):
            Print("Registered 1!")
            InputK1.Register(Agent)

    ResetPlayer(Agent:agent):void=
        if(FortCharacter := player[Agent].GetFortCharacter[]):
            FortCharacter.SetMaxShield(0.0)
        InputK1.Unregister(Agent)
        InputK2.Unregister(Agent)
        InputK3.Unregister(Agent)
        InputK4.Unregister(Agent)
        InputK5.Unregister(Agent)
        InputK6.Unregister(Agent)

        
        
    
    
        
    