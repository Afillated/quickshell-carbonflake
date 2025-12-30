#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

username="$1"

fullname=$(awk -F: -v user="$username" '$1 == user {print $5}' /etc/passwd)

if [ -n "$fullname" ]; then
    echo "$fullname" | sed 's/,$//'
else
    echo "User '$username' not found or full name not set."
    exit 1
fi

