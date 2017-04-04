#!/bin/bash

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'Nox/lb_farming_(es-exit)_no_refills_720.txt' --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'Nox/no_refills_720.txt' --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'Nox/no_refills_+_timer_720.txt' --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'Nox/tm_refills_720.txt' --outtype nox

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'Hiro/lb_farming_(es-exit)_no_refills_720.txt' --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'Hiro/no_refills_720.txt' --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'Hiro/no_refills_+_timer_720.txt' --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'Hiro/tm_refills_720.txt' --outtype hiro
