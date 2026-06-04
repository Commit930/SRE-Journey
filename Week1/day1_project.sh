#Day 1 practice users,groups,permissions

#create users
useraddd alice
useradd bob
useradd charlie

#Create group and add alice and bob
groupadd devteam
usermod -aG devteam alice
usermod -aG devteam bob

#Create a Shared directory with correct permissions
mkdir /shared
chmod 770 /shared

#Verify

group alice
group charlie
ls -la /shared
