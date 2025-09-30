sketchybar --add item battery right \
           --set battery \
           update_freq=120 \
           script="$PLUGIN_DIR/battery.sh" \
           padding_right=4 \
           --subscribe battery system_woke power_source_change \
