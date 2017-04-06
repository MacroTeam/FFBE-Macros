#!/bin/bash

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'Nox/lb_farming_(es-exit)_no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'Nox/no_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'Nox/no_refills_+_timer_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'Nox/tm_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_[480]_[memu].txt' -o 'Nox/no_refills_[480]_[memu].txt' --in-x 480 --in-y 854 --out-x 854 --out-y 480 --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_[480]_[memu].txt' -o 'Nox/no_refills_+_timer_[480]_[memu].txt' --in-x 480 --in-y 854 --out-x 854 --out-y 480 --outtype nox
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tmrefill_[480x854]_[memu].txt' -o 'Nox/tmrefill_[480x854]_[memu].txt' --in-x 480 --in-y 854 --out-x 854 --out-y 480 --flip-y --outtype nox

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/lb_farming_(es-exit)_no_refills_720.txt' -o 'Hiro/lb_farming_(es-exit)_no_refills_720.txt' --in-x 720 --in-y 1280 --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_720.txt' -o 'Hiro/no_refills_720.txt' --in-x 720 --in-y 1280 --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_720.txt' -o 'Hiro/no_refills_+_timer_720.txt' --in-x 720 --in-y 1280 --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tm_refills_720.txt' -o 'Hiro/tm_refills_720.txt' --in-x 720 --in-y 1280 --flip-y --outtype hiro

python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_[480]_[memu].txt' -o 'Hiro/no_refills_[480]_[memu].txt' --in-x 480 --in-y 854 --out-x 854 --out-y 480 --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/no_refills_+_timer_[480]_[memu].txt' -o 'Hiro/no_refills_+_timer_[480]_[memu].txt' --in-x 480 --in-y 854 --out-x 854 --out-y 480 --outtype hiro
python3 ~/Documents/code/convertMacros/convertMacros.py -i 'MEmu/tmrefill_[480x854]_[memu].txt' -o 'Hiro/tmrefill_[480x854]_[memu].txt' --in-x 480 --in-y 854 --out-x 854 --out-y 480 --flip-y --outtype hiro
