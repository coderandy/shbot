# disable history expansion
set +H

SECONDS=0

# Shorter way to enable most builtins
e() { enable -f "$1" "$1"; }

# The remaining code won't work with bash 1.x
case $BASH_VERSION in 1.*) return;; esac

# Make the timing output one line instead of four
TIMEFORMAT='real: %3lR, user: %3lU, sys: %3lS'

# extglob was introduced in 2.02
case ${BASH_VERSINFO[0]} in
    2)
        case ${BASH_VERSINFO[1]} in
            0|01) return ;;
        esac
    ;;
esac
shopt -s extglob

# globstar was introduced in 4.0
if (( BASH_VERSINFO[0] >= 4 )); then
    shopt -s globstar
fi

# Special case for trigger +#, enable all loadables
if [[ ${BASH_VERSINFO[4]} != release ]]; then
    source loadables
fi
