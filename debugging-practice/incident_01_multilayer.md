# Incident debug practice - Multi layer failures (simulated)

## Symptom
Customers and I are unable to reach the app via localhost

## Step1 - Rule out DNS
dig localhost
Returned 127.0.0.1 correctly, DNS is not the problem

## Step2 Test the actual connectivity
curl -v http://localhost
Reuqest hung indefinitely, no response at all (had to do ctrl +C)
A hang suggest something silently dropping the traffic, rather than
nothing listening atall. This pointed to the firewall

## Step3 - Check firewall rules
sudo iptables -L INPUT -v -n --line-numbers
Found a DROP rule sitting at the top line 1, ABOVE the ACCEPT
rules. Since IP tables evaluate top to bottom and stops at first match,
this DROP was catching all PORT80 traffice before it reached ACCEPT RULE
fix - sudo iptables -D INPUT 1

## Step 4 - Re-test, new issue appears
curl -v http://localhost 
This time failed to connect to the server 
A fast, explicit failure instead of hang. This specifically suggests
nothing is listening on port 80(diff from firewall rule, which would hang if it's DROP)

## Step 5 -Check if nginx(Load Balaner) is running
sudo systemctl status nginx --no-pager
showed inactive(dead). Nginx itself has stopped
Fix sudo systemctl start nginx

## step 6 - Re-test
curl http://localhost
Got a 301 permanently moved. This is correct behavior
my nginx config redirects a plain http to https

# Step 7 - Following the redirect

curl https://localhost
Got nginx's default pages. confirmed nginx/tls layer is fully healthy

## Step 8 - Test the real application

curl -k https://localhost/api/v1

Got the correct backend response. Confirmed the full chain
Firewall, nginx, TLS and backend all working

## Another scenario

If the loadbalancer (nginx) is healthy byitself and the backend is
healthy by itself, but traffic going through the load balancer is failing to reach backend
the problem is what's in between.

A firewall rule blocking the internal hop b/w nginx and the backend port, symptom would be hang/timeout,
since it's a silent drop

nginx's proxy_pass pointing to the wrong address/port entirely symptom would be a fast failure(Connection refused or 502)

The failure's speed and type (hand vs fast error) is itself a clue for which of these two to check first.