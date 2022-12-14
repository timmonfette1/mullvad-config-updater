#!/usr/bin/env bash
#
# Author: Tim Monfette
# Date: 14/12/2022
#
# Updates WireGuard config files for Mullvad to have additional
# security configurations in place.

FILECOUNT=0

for f in /etc/wireguard/*.conf; do
	echo "Adding a killswitch and preventing DNS leaks to config file $f ..."
	sed -i '/DNS =/s/.*/PostUp = systemd-resolve -i %i --set-dns=193.138.218.74 --set-domain=~./' $f
	sed -i '5 i PostUp = iptables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT' $f
	sed -i '6 i PreDown = iptables -D OUTPUT ! -o %i -m mark ! --mark $(wg show  %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -D OUTPUT ! -o %i -m mark ! --mark $(wg show  %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT' $f
	((FILECOUNT=FILECOUNT+1))
done

echo "Processed a total of $FILECOUNT config files"
