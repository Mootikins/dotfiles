#!/usr/bin/env bash

if paru -Qu &> /dev/null; then
    paru -Qu | wc -l
else
    echo "?"    
fi
