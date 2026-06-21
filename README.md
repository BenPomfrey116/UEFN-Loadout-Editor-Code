# UEFN-Loadout-Editor-Code
UEFN (Unreal Editor for Fortnite) allows the development of games within the Fortnite ecosystem. This is the code for the UI systems I created for one of my islands - a tactical-shooter-style game.

Here is the code for some of my verse devices that I created within the editor.

The LoadoutUI_device is for management of the player's UI - it includes an inhertance hierarchy structure for creating different widgets to be displayed on the player's UI canvas, and setting different switch devices to store persistant boolean data on their selected choice of weapon/item for a given loadout selection UI.

The killstreaks_device is used for managing killstreaks (items/abilities granted upon a certain streak of eliminations - called "Streak Bonuses" in-game). It has a class to store information for each player and their current streak status, giving them each streak when it is reached/unlocked. The event handling for the input trigger devices are also in this file to allow for each streak to be used accordingly.
