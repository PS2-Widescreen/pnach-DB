#!/bin/bash

cd ..
cd PNACH

for a in ./*.pnach
do
echo 	processing $a
	if [[ "$a" =~ ^[A-Z][A-Z][A-Z][A-Z][[:space:]_-][0-9][0-9][0-9].?[0-9][0-9].pnach ]]; then
		echo the name format is correct.
	else
		echo incorrect format
		ELF=$(grep -Eo '[A-Z][A-Z][A-Z][A-Z][[:space:]_-][0-9][0-9][0-9].?[0-9][0-9]' "$a" | paste -s -d ',')
		if [ -z "$ELF" ]; then
			echo "ERROR: file '$a' has no ELF ID inside, skipping..."
			continue
		fi
		echo Found ELF -- $ELF
		ELF=$(echo "$ELF" | sed 's/-/_/g')
		echo cleaned dash [$ELF]
		if [[ "$ELF" =~ [A-Z][A-Z][A-Z][A-Z][_-][0-9][0-9][0-9][0-9][0-9] ]]; then
			if [[ $ELF == *","* ]]; then
				NEWELF=""
				for i in ${ELF//,/ }
				do
					TMP=$(echo "$i" | sed 's/./&./8')
					if [[ $NEWELF == "" ]]; then
						NEWELF=$TMP
					else
						NEWELF="${NEWELF},${TMP}"
					fi
					echo NEWELF-$NEWELF
				done
				ELF=$NEWELF
			else
				ELF=$(echo "$ELF" | sed 's/./&./8')
			fi
		fi
		echo final result was $ELF
		CRC=$(basename $a .pnach)
		sed -i '/^gametitle=/ s/$/ \n\/\/ELF CRC='"$CRC"'/' "$a"
		mv "$a" "../PNACH_WITH_ID/$ELF.pnach"
	fi
done
