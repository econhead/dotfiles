#!/bin/bash

sketchybar --add item apple left \
           --set apple icon= label.drawing=off icon.padding_right=10 \
           --add item front_app left \
           --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh"  \
           --subscribe front_app front_app_switched
