#!/bin/bash

### BEGIN INIT INFO
# Provides:          fw.sh
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Firewall
# Description: Establece el firewall en este router
### END INIT INFO


# BORRAR LAS REGLAS QUE YA EXISTIESEN
iptables -F
iptables -t nat -F

# ACEPTAR LAS POLITCAS POR DEFECTO
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT


# HABILITAR EL REDIRECCIONAMIENTO
echo "1" > /proc/sys/net/ipv4/ip_forward

# ENMASCARAR LAS PETICIONES
iptables -t nat -A POSTROUTING  -o enp2s5 -j MASQUERADE
# HABILITAR EL ACCESO DEDES AULA MIX
iptables –t nat –A PREROUTING –i enp2s3 –s 172.20.3.0/24 –p tcp –-dport 2000 –j DNAT –-to IPDst:22
iptables –t nat –A PREROUTING –i enp2s3 –s 172.20.202.0/24 –p tcp –-dport 2000 –j DNAT –-to IPDst:22
