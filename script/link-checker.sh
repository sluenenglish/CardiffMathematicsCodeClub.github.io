#!/bin/bash

set -e

files=("./*.html"
       "_includes/catmenu.html"
       "_includes/post_link.html"
       "_layouts/*.html"
       "_posts/*.md"
       "editors/*.md"
       "languages/*.md")

ignore=("./404.html")

skip=0

# For every file defined by the regex's above
for f in ${files[@]}
do
    for file in $(ls $f)
    do
        # Check to see if it's a file we want to ignore
        for i in ${ignore[@]}
        do
            if [[ $i =~ $file ]];then
                skip=1 # If so then skip
            fi
        done

        if [[ $skip -eq 0 ]];then
            if grep -q "site.baseurl" $file 2> /dev/null; then
                echo "Error! site.baseurl found in $file"
                exit 1
            fi
        else
            skip=0
        fi
    done
done
