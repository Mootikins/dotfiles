#!/usr/bin/env bash

if paru -Qu &> /dev/null; then
    echo paru -Qu | grep -v ignored | wc -l
else
    echo "?"    
fi
