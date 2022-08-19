#!/bin/bash

cd ..
cd PNACH

for a in ./*.pnach
do
echo 	processing $a
	if [[ "$a" =~ ^[A-Z][A-Z][A-Z][A-Z][_-][0-9][0-9][0-9].?[0-9][0-9].pnach ]]; then
		echo the name format is correct.
	else
		echo incorrect format
		ELF=$(grep -Eo '[A-Z][A-Z][A-Z][A-Z][_-][0-9][0-9][0-9].?[0-9][0-9]' "$a")
		if [ -z "$ELF" ]; then
			echo "ERROR: file '$a' has no ELF ID inside, skipping..."
			continue
		fi
		echo $ELF
		if [[ "$ELF" =~ ^[A-Z][A-Z][A-Z][A-Z][_-][0-9][0-9][0-9][0-9][0-9] ]]; then
			ELF=$(echo "$ELF" | sed 's/./&./8')
			echo $ELF
		fi
		ELF=$(echo "$ELF" | sed 's/-/_/g')
		echo final result was $ELF
		mv $a $ELF.pnach
	fi
done
