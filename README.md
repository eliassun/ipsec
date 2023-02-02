# Demo

https://www.voipeye.com is a website to create/update/delete/list the remote VPN users and site-to-site VPN, 
including the IPSec remote user VPN, the OpenVPN user VPN, and the IPSec site-to-site VPN. It also has the 
Okta/SAML-based login, which will generate a token as a temporary password to sign in the remote VPN service.

https://eliassun.github.io/vpc-edge/index.html is the manual to operate the server. 
 
https://www.voipeye.com/get_saml_token is the link to generate the SAML token. The SAML demo account is username: elias@voipeye.com  password: Test!123

IPSec remotevpn is turned on for the VPN server www.voipeye.com, but the OpenVPN is turned off. If it needs the OpenVPN, please send the request to the email eliassun@gmail.com.

# Demo: IPSec Remote User VPN

[IPSec] Add A PSK User

[IPSec] Delete A PSK User

[IPSec] List All PSK Users

www.voipeye.com is pointed to  104.238.180.66.

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

# Demo: OpenVPN Remote User VPN

[OpenVPN] Add A User

[OpenVPN] List All Users

The OpenVPN doesn't have the firewall issue as this demo is using TCP with the port 443, 
which will be treated as a https service from the most of corporation network. But it needs
to install the cert and OpenVPN client.
After a user is created from the website, it needs to download http://http://104.238.180.66/static/download/user_name_you_input.ovpn .
Also, it needs to install the VPN client from:

https://openvpn.net/vpn-client/

OR other vendors, e.g. Aviatrix

https://read.docs.aviatrix.com/Downloads/samlclient.html

Still after the VPN connection is made from the client installed, then verify it by:

ping 172.16.1.200

# Demo: Okta/SAML Remote User VPN
This feature can create a single username for both IPSec remote VPN and OpenVPN. 
The endpoint user will login Okta/SAML first to generate a temporary token for 
both IPSec remote VPN and OpenVPN. e.g. iOS can use the e-mail and the token to login VPN service.
Then the MacOS/Win still can use the same e-mail and the same token to login the OpenVPN.

1st step: Configure SAML App in IDP(e.g. Okta) ---> one time deal

2nd step: Configure this App with the result of 1st step --> one time deal

3nd step: Generate token for iOS/MacOS/Win/Linux VPN login ---> For every new login. 
One login can last 1-24 hours, it depends on settings.

For "1st step", it will configure an App in Okta, including the "App Name",  "Single Sign On URL", 
"Entity ID"("Audience Restriction") and "Attributes". Then configure users(e-mail) to use this App. 

For "2nd step", go to this demo website, configure the "App Name", """Single Sign On URL" and "Entity ID" 
into "Add SAML App". Then Add the users(e-mail) into "Add User".

After the "2nd step", go to "List Apps AND Generate Token" to get a new token to login VPN service. 
The username to login VPN service is the e-mail to login Okta/SAML IDP.


# Demo: IPSec Site-to-Site VPN

[IPSec Site-to-Site] Add A Connection

[IPSec Site-to-Site] Delete A Connection

[IPSec Site-to-Site] List All Connections

[IPSec Site-to-Site] Up Connection

[IPSec Site-to-Site] Check Connections' States


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
