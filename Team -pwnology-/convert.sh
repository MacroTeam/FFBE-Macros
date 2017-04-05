#only handles the base ultimate TM for testing of fixes in vortexfix branch

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_speedup_v2.0_-_auto_+_close_feedback_+_new_positioning.txt' -o 'Nox/tm_speedup_v2.1_-_auto_+_close_feedback_+_repositioning.txt' --outtype nox

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_speedup_v2.0_-_auto_+_close_feedback_+_new_positioning.txt' -o 'Hiro/ultimate_tm_macro_hiromacro.txt' --outtype hiro
