#!/bin/bash

echo "TOTAL CPU USUAGE "
top -bn2 | grep '%Cpu' | tail -1 | grep -P '(....|...) id,'|awk '{print "CPU Usage: " 100-$8 "%"}'

echo ""
echo "TOTAL MEMORY USAGE"
echo ""

read total used free <<< $(free -m | awk '/^Mem:/ {print $2, $3, $4}')
percent=$(echo "scale=1; $used/$total * 100" | bc)

echo "Used:  $used MB"
echo "Free:  $free MB"
echo "Total:  $total MB"
echo "Usage:  $percent %"

echo ""
echo "TOTAL DISK USAGE"
echo ""

read total used avail percent <<< $(df -h --total | awk '/^total/ {print $2, $3, $4, $5}')

echo "Used:  $used"
echo "Free:  $avail"
echo "Total:  $total"
echo "Usage:  $percent"

echo ""
echo "TOP FIVE PROCESS BY CPU USAGE"
echo ""

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ""
echo "TOP FIVE PROCESS BY MEMORY USAGE"
echo ""

ps -eo pid,comm,%mem --sort=-%mem | head -n 6
