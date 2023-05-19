wsl -d Ubuntu-18.04 -u root ip addr del $(ip addr show eth0 ^| grep 'inet\b' ^| awk '{print $2}' ^| head -n 1) dev eth0
wsl -d Ubuntu-18.04 -u root ip addr add 172.30.144.16/20 broadcast 172.30.159.255 dev eth0
wsl -d Ubuntu-18.04 -u root sudo ip route add 0.0.0.0/0 via 172.30.144.1 dev eth0
wsl -d Ubuntu-18.04 -u root echo nameserver 172.30.144.1 ^> /etc/resolv.conf
powershell -c "Get-NetAdapter 'vEthernet (WSL)' | Get-NetIPAddress | Remove-NetIPAddress -Confirm:$False; New-NetIPAddress -IPAddress 172.30.144.1 -PrefixLength 20 -InterfaceAlias 'vEthernet (WSL)'; Get-NetNat | ? Name -Eq WSLNat | Remove-NetNat -Confirm:$False; New-NetNat -Name WSLNat -InternalIPInterfaceAddressPrefix 172.30.144.0/20;"