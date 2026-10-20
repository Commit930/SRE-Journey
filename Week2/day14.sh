FAIL=0
check_api_v1() {
    if curl -sk http://localhost:8081 | grep -q "8081";then
    echo "OK: app is running on 8081"

    else
    echo "WARN: app is not running on 8081"
    FAIL=1

    fi
   

}


check_api_v2() {
    if curl -sk http://localhost:8082 | grep -q "8082";then
    echo "OK: app is running on 8082"

    else
    echo "WARN: app is not running on 8082"
    FAIL=1
    fi
   

}


check_api_v1
check_api_v2
exit $FAIL


