#!/bin/bash

SINK=$(pactl list sinks short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
LEVEL=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

echo $LEVEL