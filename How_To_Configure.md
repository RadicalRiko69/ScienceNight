# How to add missions, configure free play, etc
ScienceNight contains a fully functional unlock system, although I haven't exactly tested it.

In ScienceNight, groups contain songs, and songs contain mission step charts. Completing all step charts in a mission unlocks that song for free play.

## Step 1. Configure groups to show up in mission mode

Head to Scripts/09 QuestMode.lua and modify the MISSION_GROUPS table. This table contains the mission groups, duh.
So if you have a folder of songs which contain missions named GROUP 1, you would put in GROUP 1.

## Step 2. Add the song to unlock after beating all missions in a song

Add a #SONGUNLOCK tag somewhere in your ssc with the name of the song to unlock for free play.
Yes, mission songs are separate from free play songs, it's not like SM supports hiding charts.

## Step 3. Configure default unlocks for free play

Head to Scripts/10 SN-ProcessFPUnlocks.lua and read the instructions.

Also make sure you modify Scripts/00 SYSTEM PARAMETERS.lua for what groups that can actually be displayed in free play.
