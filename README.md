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
cd site1
terraform init
terraform apply --auto-approve

cd ..
Usage:
cd site2
terraform init
terraform apply --auto-approve