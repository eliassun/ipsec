# Demo
http://104.238.180.66 is a website to create/update/delete/list the IPSec remote VPN users.
After a user is created, MacOS/iPhone/Windows with this user name and password can connect to this server 104.238.180.66.

MacOS/iPhone VPN configuration sample, (MacOS Network Settings-->VPN, iOS Settings-->VPN):

Server Name: 104.238.180.66

Remote ID: 104.238.180.66

Local ID: elias(or the user you created)

Type: None

Select: Shared Secret

Shared Key: 1(or password you created)

Toggle the VPN switch to connect. After the VPN connection is done, verify it by:

ping 172.16.1.200

The production should have the more features, including Admin web login, OKTA/SAML VPN authentication, 
the split/full tunnel, profile based routes, and even the remote VPN and site-to-site VPN bridge.

This demo server only routes 172.16.0.0/16 of the client to the server, and it is a public IPSec test server only, 
not routing all traffic of the client to the Internet through this server. It is a split tunnel mode.

Finally, it needs to make sure the firewall opens the UDP 50 and 4500, even the ESP, 
if the clients(e.g. MacOS) is in a corporation network, which has the strict rules. It should work fine in the
home network. If the client is on linux, then it needs to make sure ufw will not block 50 and 4500.

# ipsec
These site1/2 scripts set up a site-to-site IPSec with the correct security group in two AWS VPCs, including:

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
