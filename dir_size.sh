#!/bin/bash
traverse() {
    dir=()
    for x in $@; do
        IFS=$'\n'
        for i in $(ls -l $x); do
            file_type=$(echo $i | awk '{print substr($1,0,1)}')
            if [[ $file_type = "d" ]]
            then
                dir+=( $x/$(echo $i | awk '{print $9}') )
            fi
            if [[ $file_type = "-" ]]
            then
                b=$(echo $i | awk '{print $5}')
                sum=$((sum + b))
            fi
        done
    done
    if [[ ${#dir[*]} > 0 ]]
    then
        traverse "${dir[@]}"
    else
        return
    fi
}
sum=0
traverse $1
echo $sum
