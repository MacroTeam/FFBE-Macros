#!/bin/bash

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'Nox/lb_farming_(es-exit)_no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'Nox/no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'Nox/no_refills_+_timer_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'Nox/tm_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'Hiro/lb_farming_(es-exit)_no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'Hiro/no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'Hiro/no_refills_+_timer_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'Hiro/tm_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype hiro

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'MEmu/y-flipped/lb_farming_(es-exit)_no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype memu
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'MEmu/y-flipped/no_refills_720-flipped.txt' --in-x 720 --in-y 1280 --flip-y --outtype memu
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'MEmu/y-flipped/no_refills_+_timer_720-flipped.txt' --in-x 720 --in-y 1280 --flip-y --outtype memu
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'MEmu/y-flipped/tm_refills_720-flipped.txt' --in-x 720 --in-y 1280 --flip-y --outtype memu
