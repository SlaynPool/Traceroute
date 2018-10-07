#!/bin/bash 
#obsolète

echo "digraph G{" > test.xdot

while read ligne
do

echo $(echo "\"")$(echo $ligne| cut -d " " -f 2) $(echo "\"") $(echo "->") >> test.xdot
done < resulte.txt
echo "}">> test.xdot
