# README

This is to implement 2 networks and subnets and connect them with HA VPN gateways.

It uses Cloud Router interface and peering

This task doesn't use any resources created anywhere else


```

gcloud compute instances create instance1 --zone us-central1-a --subnet ha-vpn-subnet-1
gcloud compute instances create instance2 --zone us-west1-a --subnet ha-vpn-subnet-2
gcloud compute instances create instance3 --zone us-central1-a --subnet ha-vpn-subnet-3
gcloud compute instances create instance4 --zone us-east1-b --subnet ha-vpn-subnet-4


# create a new vpc to peer to vpn1
gcloud compute networks create vpc-demo --subnet-mode custom --project simartar-proj-01
gcloud beta compute networks subnets create vpc-demo-subnet1 --project simartar-proj-01 \
--network vpc-demo --range 10.1.1.0/24 --region us-central1

# peering
# a to b
gcloud compute networks peerings create peer-ab \
    --project simartar-proj-01 \
    --network vpc-demo \
    --peer-project lab-proj-02 \
    --peer-network network1 \
    --import-custom-routes \
    --export-custom-routes

# b to a
gcloud compute networks peerings create peer-ba \
     --project lab-proj-02 \
     --network network1 \
     --peer-project simartar-proj-01 \
     --peer-network vpc-demo \
     --import-custom-routes \
     --export-custom-routes

gcloud compute networks peerings list --network network1 --project lab-proj-02

# create an instance in vpc-demo network
gcloud compute instances create instance0 --zone us-central1-b \
 --subnet vpc-demo-subnet1  --project simartar-proj-01

gcloud compute firewall-rules create allow-all-demo --network vpc-demo \
--project simartar-proj-01 \
--allow tcp,udp,icmp --source-ranges 10.0.0.0/8,192.168.0.0/16

gcloud compute firewall-rules create allow-ssh-from-all --network vpc-demo \
--project simartar-proj-01 \
--allow tcp:22 --source-ranges 0.0.0.0/0

# this is important, you have to setup this static route for the distination network
# to be able to communicate back to the vpc-demo network
gcloud compute routes create network2-to-vpc-demo-1 \
--destination-range 10.1.1.0/24 \
--next-hop-vpn-tunnel ha-vpn-tunnel3 \
--network network2 \
--project lab-proj-02 \
--next-hop-vpn-tunnel-region us-central1 \
--priority 810

gcloud compute routes create network2-to-vpc-demo-2 \
--destination-range 10.1.1.0/24 \
--next-hop-vpn-tunnel ha-vpn-tunnel4 \
--network network2 \
--project lab-proj-02 \
--next-hop-vpn-tunnel-region us-central1 \
--priority 820

gcloud compute routes list --project lab-proj-02 --filter="network='network2'"
```