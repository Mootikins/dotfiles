#!/usr/bin/env bash
# This script uses getopt (not getopts) and checks if Spotify is running so
# that it can determine whether or not to send a dbus command to spotify or to
# control mpd

if [[ $# -ne 1 ]]; then
   echo "Improper number of arguments, should be one -- valid arguments are playpause, next, prev"
   exit 1
fi

case $1 in
playpause)
   if pgrep -x spotify >/dev/null; then
      dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
   else
      mpc toggle
   fi
   ;;
next)
   if pgrep -x spotify >/dev/null; then
      dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
   else
      mpc next
   fi
   ;;
prev)
   if pgrep -x spotify >/dev/null; then
      dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
   else
      mpc prev
   fi
   ;;
*)
   echo "Improper argument -- should be playpause, next, or prev"
   ;;
esac
