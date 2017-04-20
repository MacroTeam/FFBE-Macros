# Exploration Design

1. **[Intro](#Intro)**
1. **[StageSelect](#1.StageSelect)**
2. **[ClearZone1](#2.ClearZone1)**
3. **[Nav1](#3.Nav1)**
4. **[ClearZone2](#4.ClearZone2)**
5. **[Nav2](#5.Nav2)**
6. **[Boss](#6.Boss)**
7. **[Nav3](#7.Nav3)**
8. **[Exit](#8.Exit)**
9. **[Summary](#Summary)**

# Intro

to begin with - let's put something out on the table - exploration macro's are a massive pain in the ass. The amount of steps to calculate and work with can be quite challenging to get them to work 100% of the time - and if something's wrong, it's extremely difficult to manually go back and tweak a certain line.
Rather than making separate scripts for each individual exploration (which is rather time consuming) following a bit of discussion K&K came up with a great idea to make things modular. 
Why Modular? - well - when you think about the entire run, about 80~90% of the run is all the same process. - the only bit that really changes (other than the visual) is the navigating through the stage. 
Other than that the only other changes are things like UI changes when the game is patched and a button press is added in an awkward location.
Now whilst natively, Nox and Memu both have functionality to play an existing script whilst recording, you suffer certain timing delays in the form of a large pause whilst you stop script 1 and start script 2, if you do need to make a change later down the line, the only way of pumping out a full macro, is to go and run the whole exploration again, which at 30 mins a run makes thinigs a bit difficult.
So how could we rapidly make changes to aspects of code whilst also allowing us to pump out new scripts at a rapid rate? - Kastyr had already developed his conversion tool allowing macro's to be converted into syntax for different tools, and had played with a merge tool historically, but hadn't quite gotten it to 100%.
It took a bit of testing, but the merge tool was completed and we were in a position to start pumping things out.
The next step was the break down the Exploration run as a whole into manageable sections:

# 1.StageSelect

This is Stage 1 required in Writing the Exploration Script. It takes you from the Stage Select Screen, through picking a companion, and beginning the level. If you are low on NRG this WILL pay for a refill. It also clears the daily quest completion pop-up that can appear when scripts loop.

# 2.ClearZone1 

This clears all mobs in Current Area using a diagonal wriggle movement

# 3.Nav1 

This Section Navigates Sprite to a Neutral Location to ensure sustainability of script, & Then Navigates through to Area 2. Navigate to known safe position hitting 2x walls to ensure remainder of script operates. Then move sprite to area 2. Collecting Collection Points if relevant to exploration.

# 4.ClearZone2 

This clears all mobs in Current Area using a wriggle movement

# 5.Nav2 

This Section Navigates Sprite to Neutral Location to ensure sustainability of script, & Then Navigates through remaiander of area collecting gathering points as required.
Navigate to known safe position hitting 2x walls to ensure remainder of script operates. Then move sprite onwards from there End location is boss battle notification giving option to fight boss or return.

# 6.Boss 

This covers boss fight automation. Start Location is clicking the start fight button Multiple auto button presses 3s apart to alleviate any concerns over auto-battle.

# 7.Nav3 

Not always required in all stages - Exploration cleanup to Exit Button Click Continue, Collect remaining drop points and navigate to exit

# 8.Exit

Go through finish screen and reset to stage select screen.

# Summary

The Nav Stages - Points 3, 5, 7 will be unique PER exploration - remaining points can be set in stone.

In addition to this, (and visible if you are intrigued at looking at some of the stage code within the repo), there are sometimes requirements for some additional stages. These can be to move away from dead locations, or to modify existing stages.

The output of all of this, is that if a tweak or change is required, to an aspect of a script, the change can be made on a much smaller scale, and then the script recompiled with the change. In the instance of a UI Update, only the affected module needs to be updated, and then all scripts can be patched with the update immediately.

Anyhow - hopefully that's a bit of insight into how the scripts are put together and generated for those that like an essay.
