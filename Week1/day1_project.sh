#Day 1 practice users,groups,permissions

#create users
sudo useraddd alice
sudo useradd bob
sudo useradd charlie

#Create group and add alice and bob
sudo groupadd devteam
sudo usermod -aG devteam alice
sudo usermod -aG devteam bob

#Create a Shared directory with correct permissions
mkdir /shared
sudo chown root:devteam /shared
chmod 770 /shared

#Verify

group alice
group charlie

#verify permissions
ls -la /shared
