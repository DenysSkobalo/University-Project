#!/bin/sh
echo -ne '\033c\033]0;University-project\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/University-project.x86_64" "$@"
