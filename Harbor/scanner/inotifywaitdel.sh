#!/bin/bash
DIR="/home/scanner/.cache/reports"
inotifywait -m -r -e delete "$DIR" --format '%f' | while read f

do
    # you may want to release the monkey after the test :)
    echo "     === File $f deleting. Start parser script ==="
    /home/scanner/parser.sh /home/scanner/reports/$f
    # <whatever_command_or_script_you_liketorun>
done