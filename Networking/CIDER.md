# Cider


CIDR IP addresses consist of two groups of numbers, which are also referred to as groups of bits. The most important of these groups is the network address, and it is used to identify a network or a sub-network (subnet). The lesser of the bit groups is the host identifier. The host identifier is used to determine which host or device on the network should receive incoming information packets. In contrast to classful routing, which categorizes addresses into one of three blocks, CIDR allows for blocks of IP addresses to be allocated to Internet service providers. The blocks are then split up and assigned to the provider’s customers. Until recently, IP addresses used the IPv4 CIDR standard, but because IPv4 addresses are nearly exhausted, a new standard known as IPv6 has been developed and will soon be implemented.
The difference between IPv4 and IPv6

There are two revisions of the IP protocol that are widely implemented on systems today. IPv4, which is the fourth version of the protocol, currently is what the majority of systems support. The newer, sixth revision, called IPv6, is being rolled out with greater frequency due to improvements in the protocol and the limitations of IPv4 address space. Simply put, the world now has too many internet-connected devices for the amount of addresses available through IPv4.

## Pv4

IPv4 addresses are 32-bit addresses. Each byte, or 8-bit segment of the address, is divided by a period and typically expressed as a number 0-255. Even though these numbers are typically expressed in decimal to aid in human comprehension, each segment is usually referred to as an octet to express the fact that it is a representation of 8 bits.

## Private Netzwerke

Adressbereich | Klasse
--------------| -------
10.0.0.0 bis 10.255.255.255 | Class A Netz
172.16.0.0 bis 172.31.255.255 | Class B Netz
192.168.0.0 bis 192.168.255.255 | Class C Netz

## Aufgabenstellung

Subnet Address | Netmask | Useable IPs | Hosts 
---------------| --------| -------------------|-------------| ------
10.0.0.0/22 | 255.255.252.0 | 10.0.0.1 - 10.0.3.254 | 1022
10.0.4.0/22 | 255.255.252.0 | 10.0.4.1 - 10.0.7.254 | 1022
10.0.8.0/22 | 255.255.252.0 | 10.0.8.1 - 10.0.11.254 | 1022
10.0.12.0/22 | 255.255.252.0 | 10.0.12.1 - 10.0.15.254 | 1022
10.0.16.0/22 | 255.255.252.0 | 10.0.16.1 - 10.0.19.254 | 1022
10.0.20.0/22 | 255.255.252.0 | 10.0.20.1 - 10.0.23.254 | 1022
10.0.24.0/22 | 255.255.252.0 | 10.0.24.1 - 10.0.27.254 | 1022
10.0.28.0/22 | 255.255.252.0 | 10.0.28.1 - 10.0.29.254 | 510
10.0.30.0/22 | 255.255.252.0 | 10.0.30.1 - 10.0.31.254 | 510
