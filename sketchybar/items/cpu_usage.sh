sketchybar --add item cpu_usage right \
           --set cpu_usage icon=􀫥 \
                          icon.font="Hack Nerd Font:Bold:14.0" \
                          icon.color=0xffcba6f7 \
                          label.color=0xffcba6f7 \
                          script="$PLUGIN_DIR/cpu_usage.sh" \
                          update_freq=5
