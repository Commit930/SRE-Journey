SERVICES=(nginx sshd cron)

for SERVICE in "${SERVICES[@]}"; do
if systemctl is-active --quiet "$SERVICE"; then
echo "OK: $SERVICE is running"
else
echo "WARN: $SERVICE is not running"
fi 
done


COUNT=0
while [ $COUNT -lt 5 ]; do
echo "Loop iteration: $COUNT"
COUNT=$((COUNT + 1))
done