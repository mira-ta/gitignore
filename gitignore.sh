#!/bin/sh

echoerr() {
    # same as echo but uses cat to redirect text to stderr.
    cat >&2 <<< "${*}"; 
}

usage() {
    cat << __USAGE
Usage: gitignore [OPTIONS] <LANGUAGE>

Options:
    -b, --branch <BRANCH>               Specify source branch ref (default: master)
    -o, --output <FILE>                 Specify output file (default: .gitignore)
    -h, --help                          Print help information.
__USAGE
}

# Parse input arguments.
parse_args() {
    for arg in "$@"; do
        case "${arg}" in
            -b|--branch)
                export REMOTE_BRANCH="${2}";
                shift; shift;;
            -o|--output)
                export OUTPUT_FILE="${2}";
                shift; shift;;
            -h|--help)
                usage;
                exit;;
        esac;
    done;

    # expecting one argument left
    if [ -n "${*}" ]; then
        export GITIGNORE_TYPE="${*}";
    else
        echoerr "Gitignore file is not provided. I don't know what gitignore to download.";
        exit;
    fi;

    if [ -z "${REMOTE_BRANCH}" ]; then
        export REMOTE_BRANCH="master";
    fi;

    if [ -z "${OUTPUT_FILE}" ]; then
        export OUTPUT_FILE=".gitignore";
    fi;
}

execute() {
    curl "https://raw.githubusercontent.com/github/gitignore/${REMOTE_BRANCH}/${GITIGNORE_TYPE}" -o "${OUTPUT_FILE}";
}

parse_args "${@}";

execute;
