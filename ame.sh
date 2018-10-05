#!/bin/bash 
declare -a max_TTL=(1)
taille=$(traceroute -n -I $1|tail -n 1 |cut -c1-2 )
echo $taille
while [ i -lt $taille ]
do 
	max_TTL=("${max_TTL[@]}" $i)
done
echo ${max_TTL[@]}
