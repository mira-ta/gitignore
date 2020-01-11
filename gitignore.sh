#!/bin/sh
__DESCRIPTION="Utility to download different gitignore files from public repository on mirror github using raw.githubusercontent.com.";
__USAGE="Usage:
    gitignore [OPTIONS] <TYPE> <OUTPUT>

$__DESCRIPTION  

Options:
    --branch <BRANCH>                   Use specified branch in repository (default: master)
    --mirror <HREF>                     Use specified mirror (default: raw.githubusercontent.com)
    --repository <USER/REPOSITORY>      Specify repository address (default: github/gitignore)
    --command <CMD>                     Use 'curl' either 'wget' to download data (default: wget)
    -o, --output                        Print .gitignore to STDOUT.
    -h ,--help                          Print help info.

Type: type of the .gitignore (default: NOT SET)

Output: file to output (default: .gitignore)";

BRANCH="master";
MIRROR="raw.githubusercontent.com";
REPOSITORY="github/gitignore";
COMMAND="wget";
DO_STDOUT="/bin/false";

# parse arguments
for argument in "$@"; do
    case "$argument" in
        --branch)
            shift;
            BRANCH="$1";
            shift;;
        --mirror)
            shift;
            MIRROR="$1";
            shift;;
        --command)
            shift; 
            COMMAND="$1";
            shift;;
        --repository)
            shift;
            REPOSITORY="$1";
            shift;;
        -o|--output)
            shift;
            DO_STDOUT="/bin/true";;
        -h|--help)
            echo "$__USAGE";
            exit;;
    esac;
done;

if [ -z "$1" ]; then "$0" --help; exit; else TYPE="$1"; shift; fi;
if [ -z "$*" ]; then OUTPUT=".gitignore"; else OUTPUT="$*"; fi;

URL="https://$MIRROR/$REPOSITORY/$BRANCH/$TYPE.gitignore";

if [ "$COMMAND" = "wget" ]; then
    if $DO_STDOUT; then
        wget -O - -q "$URL";
    else
        wget -O "$OUTPUT" -q "$URL";
    fi;
elif [ "$COMMAND" = "curl" ]; then
    if $DO_STDOUT; then
        curl "$URL";
    else
        curl "$URL" -o "$OUTPUT";
    fi;
else
    echo "Unknown command.";
fi;
