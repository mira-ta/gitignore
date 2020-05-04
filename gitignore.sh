#!/bin/sh

echoerr() {
    # same as echo but uses redirects text to stderr.
    echo "${*}" >&2;
}

usage() {
    cat << __USAGE
Usage: gitignore [OPTIONS] <LANGUAGE>

Options:
    LANGUAGE                            Name of gitignore file in GitHub's repository

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
                REMOTE_BRANCH="${2}";
                shift; shift;;
            -o|--output)
                OUTPUT_FILE="${2}";
                shift; shift;;
            -h|--help)
                usage;
                exit;;
        esac;
    done;

    # expecting one argument left
    if [ -n "${*}" ]; then
        GITIGNORE_TYPE="${*}";
    else
        echoerr "Name of gitignore file is not provided. I don't know what gitignore to download.";
        exit;
    fi;

    if [ -z "${REMOTE_BRANCH}" ]; then
        REMOTE_BRANCH="master";
    fi;

    if [ -z "${OUTPUT_FILE}" ]; then
        OUTPUT_FILE=".gitignore";
    fi;
}

execute() {
    curl "https://raw.githubusercontent.com/github/gitignore/${REMOTE_BRANCH}/${GITIGNORE_TYPE}.gitignore" -o "${OUTPUT_FILE}";
}

parse_args "${@}";

execute;
