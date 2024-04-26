#!/bin/bash
DIR="/home/scanner/.cache/reports"
inotifywait -m -r -e create "$DIR" --format '%f' | while read f

do
    # you may want to release the monkey after the test :)
    echo "     === File $f creating ==="
    ln /home/scanner/.cache/reports/$f /home/scanner/reports/$f
    # <whatever_command_or_script_you_liketorun>
done