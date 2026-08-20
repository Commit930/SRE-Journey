

log() {

    local LEVEL=$1
    local message=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $message"
}
log "INFO" "first function in bash"
    

check_disk() {
    local THRESHOLD="${1:-80}"
    local USAGE
    USAGE=$(df / | awk 'NR==2 {print$5}'| tr -d '%')
    if [ $USAGE -gt $THRESHOLD ]; then
    echo "WARN: Disk Usage is at $USAGE"
    else
    echo "OK: Disk Usage is at $USAGE"
    fi
}
check_disk 88
check_disk 5