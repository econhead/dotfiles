sketchybar --add item volume right \
            --set volume \
            script="$PLUGIN_DIR/volume.sh" \
            padding_right=4 \
           --subscribe volume volume_change \

