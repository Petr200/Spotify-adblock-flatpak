#!/bin/bash

# Initialize variables
LAST_SONG=""
CURRENT_SONG=$(playerctl -p spotify metadata mpris:trackid 2>/dev/null)

# Notify that the script has started
notify-send -t 1600 "Start" "Script started"

# Monitor Spotify metadata changes using playerctl
playerctl -p spotify metadata mpris:trackid --follow --format "{{mpris:trackid}}" | while read -r CURRENT_SONG; do

    # If the ID is empty (Spotify is closed/stopped), keep waiting
    if [ "$CURRENT_SONG" == "" ]; then
        continue
    fi

    # Check if Spotify is currently playing
    if [ "$(playerctl -p spotify status 2>/dev/null)" = "Playing" ]; then

        # Detect advertisement (if trackid contains "spotify/ad")
        if [[ "$CURRENT_SONG" == *"spotify/ad"* ]]; then
            notify-send -t 1600 -i com.spotify.Client -a "Spotify" "Advertising" "Skipping Advertisement..."

            # Kill the Spotify Flatpak instance
            flatpak kill com.spotify.Client &
            sleep 0.5

            # Restart Spotify in minimized mode
            flatpak run com.spotify.Client --minimized &

            # Wait until Spotify is fully loaded again
            while ! playerctl -p spotify status >/dev/null 2>&1; do
                sleep 0.5
            done

            # Check if the same song loaded (to prevent an endless loop)
            CURRENT_SONG=$(playerctl -p spotify metadata mpris:trackid 2>/dev/null)
            if [ "$CURRENT_SONG" = "$LAST_SONG" ]; then
                playerctl -p spotify next
            fi

            # If the player is paused after restart, resume playback
            if [ "$(playerctl -p spotify status 2>/dev/null)" = "Paused" ]; then
                playerctl -p spotify play
            fi
        else
            # If it's not an ad, save the track ID as the last played song
            LAST_SONG="$CURRENT_SONG"
        fi
    fi
done
