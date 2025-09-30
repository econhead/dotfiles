#!/bin/bash
sketchybar --add event aerospace_workspace_change

sketchybar --add item window_title left \
           --set window_title icon=\
                               label.font="SF Pro:Semibold:14.0" \
                               icon.padding_left=0 \
                               width=dynamic \
                               updates=on \
                               update_freq=1 \
                               script="$PLUGIN_DIR/aerospace_window_title.sh" \
          --subscribe window_title aerospace_workspace_change

