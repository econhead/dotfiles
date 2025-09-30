#!/bin/bash

sketchybar --add item music left \
           --set music \
             script="$PLUGIN_DIR/music.sh" \
             icon= \
             label.padding_left=0 \
             icon.padding_right=8 \
             label.color=0xffa6e3a1 \
             icon.color=0xffa6e3a1 \
             click_script="open -a Spotify" \
             update_freq=2 \
             drawing=off \    # start hidden
           --subscribe music media_change

