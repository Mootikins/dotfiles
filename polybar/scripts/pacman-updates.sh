#!/usr/bin/env bash

if yay -Qu > /dev/null; then
    yay -Qu | wc -l
else
    echo "?"    
fi
