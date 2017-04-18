#usage: mergeMacros.py [-h] -i [INFILE] MERGEFILES [MERGEFILES ...]
#                      [-o [OUTFILE]] [-k [KEYMAPFILE]] [-l MERGELINE]
#                      [--in-x INXREZ] [--in-y INYREZ] [--merge-x MERGEXREZ]
#                      [--merge-y MERGEYREZ] [--out-x OUTXREZ]
#                      [--out-y OUTYREZ] --outtype OUTTYPE [--new-nox]
#mergeMacros.py: error: the following arguments are required: -i, -m, --outtype


#"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox"
#1.Stage Selection-ExplorationOpen
#2.4. ClearZone
#6. Boss
#8. Exit&Return.v2.NewNox

#"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/MagicLibrary"
#ML Nav1
#ML Nav2

python3 /home/mikey/Documents/code/convertMacros/mergeMacros.py \
-i "/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/0.0 Clear Daily Pop-up" -m \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/1.Stage Selection-ExplorationOpen" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/X. 4s Delay" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/X. 2s Delay" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/InvincibleInterior/II.Nav0.v1" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/InvincibleInterior/II.Nav1.v1" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/2.4. ClearZone" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/InvincibleInterior/II.Nav2.v1" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/6. Boss" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/X. 4s Delay" \
"/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/8.Exit.v6" \
-o "/home/mikey/Documents/code/head/FFBE-Macros/Kawoxux/Exploration Automation - Nox/InvincibleInterior/Invincible Interior.txt" \
--outtype nox --new-nox
