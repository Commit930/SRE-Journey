FAIL=0
check_disk() {
    local disk_usage
    disk_usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    if [ $disk_usage -gt 80 ]; then
    echo "WARN: Disk Usage is at ${disk_usage}%"
    FAIL=1
    else
    echo " OK: Disk Usage is at ${disk_usage}%"

    fi
}

FAIL=0
check_memory () {
    local mem_total
    local mem_used
    local mem_pct
    mem_total=$(free -m | awk 'NR==2  {print $2}')
    mem_used=$(free -m | awk 'NR==2 {print $3}')
    mem_pct=$((mem_used * 100 / mem_total))
    if [ $mem_pct -gt 80 ]; then
    echo "WARN: Memory Usage is at ${mem_pct}%"
    FAIL=1
    else
    echo "OK: Memory Usage is at ${mem_pct}%"
    fi


}