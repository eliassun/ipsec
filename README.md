# Demo
http://104.238.180.66 is a website to create/update/delete/list the IPSec remote VPN users.
After a user is created, MacOS/iPhone/Windows with this user name and password can connect to this server 104.238.180.66.
e.g. MacOS/iPhone

Server Name: 104.238.180.66

Remote ID: 104.238.180.66

Local ID: elias(or the user you created)

Type: None

Select: Shared Secret

Shared Key: 1(or password you created)

The formal production should have the more features, including Admin web login, OKTA/SAML VPN authentication, the remote VPN and site-to-site VPN bridge.

I do not route the incoming VPN traffic to the Internet. So, it only can visit this server, that means it is for the IPSec VPN testing purpose.

# ipsec
These scripts set up a site-to-site IPSec with the correct security group in two AWS VPCs, including:

* Install, update and upgrade Ubuntu 22 to the latest version

* Install strongSwan

* Create the certs that strongSwan needs

More:

* IPSec route
https://eliassun.github.io/strongSwan_route.txt 

* IPSec remote access VPN (MacOS)
https://eliassun.github.io/ipsec-remote.txt

* IPSec data link decryption
https://eliassun.github.io/strongwan_decrpyt.txt

Usage:

Add the correct AWS keys into variable.tf

cd site1

terraform init

terraform apply --auto-approve

cd ..

cd site2

terraform init

terraform apply --auto-approve
