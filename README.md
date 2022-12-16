# ipsec
These scripts set up a site-to-site IPSec with the correct security group in two AWS VPCs, including:

1. Install, update and upgrade Ubuntu 22 to the latest version

2. Install strongSwan

3. Create the certs that strongSwan needs

For the IPSec for the remote access VPN(User VPN), it can found from my writing https://eliassun.github.io/ipsec-remote.txt
My tech log shows how to configure a site-to-site IPSec:
https://eliassun.github.io/strongwan.txt 

A completed network setup by Terraform, instead of the current simple setup:
https://github.com/eliassun/net4clouds

Others:

https://eliassun.github.io/strongSwan_route.txt for the network routing

https://eliassun.github.io/strongwan_decrpyt.txt decrpyts IPSec link. 
