#!/bin/sh

# Functions ==============================================
source ~/amazon-ses/functions.sh
# ============================================== Functions


if [[ $1 == "-h" ||$1 == "--help" ]]
then
        show_usage
        exit 0
fi

# parse options
for arg in "$@"; do
  shift
  case "$arg" in
    "--from")                   set -- "$@" "-f" ;;
    "--to")                             set -- "$@" "-t" ;;
    "--smtp-username")  set -- "$@" "-u" ;;
    "--smtp-password")  set -- "$@" "-p" ;;
    "--to-name")                set -- "$@" "-n" ;;
    *)                                  set -- "$@" "$arg"
  esac
done

while getopts ":f:t:u:p:n:" o; do
    case "${o}" in
        f)
            f=${OPTARG}
            ;;
        t)
            t=${OPTARG}
            ;;
        u)
            u=${OPTARG}
            ;;
                p)
                p=${OPTARG}
                ;;
                n)
                    n=${OPTARG}
                    ;;
        *)
            show_usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${f}" ] || [ -z "${t}" ] || [ -z "${u}" ] || [ -z "${p}" ] || [ -z "${n}" ]; then
    show_usage
fi

# Assign vars
FROM=$f
TO=$t
TONAME=$n
USERNAME=$u
PASSWORD=$p

# Get the files from the repo
$(wget https://raw.githubusercontent.com/LightboxDigital/AWS-SES-TEST/master/ses-template.php)
$(wget https://raw.githubusercontent.com/LightboxDigital/AWS-SES-TEST/master/composer.json)

# Install
$(composer install)

# Switch out vars in php script
sed -e "s/\[\[FROM-ADDRESS\]\]/$FROM/g" -e "s/\[\[RECEIVER-ADDRESS\]\]/$TO/g" -e "s/\[\[RECEIVER-NAME\]\]/$TONAME/g" -e "s/\[\[SMTP-USERNAME\]\]/$USERNAME/g" -e "s/\[\[SMTP-PASSWORD\]\]/$PASSWORD/g" $(pwd)"/ses-template.php" > $(pwd)"/amazon-ses-test.php"
$(rm -f ses-template.php)

# Run
OUTPUT=$(php -f amazon-ses-test.php)
echo $OUTPUT;

# Clean up
#$(rm -f composer.lock)
#$(rm -f composer.json)
#$(rm -rf vendor)
#$(rm -f amazon-ses-test.php)

_echo "Complete."
