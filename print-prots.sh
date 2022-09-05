#!/bin/bash

# Print the ports of the connection at this time.
# Use -4 as an argument to limit to tcpv4 ports.

netstat -nutl ${1} | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'

