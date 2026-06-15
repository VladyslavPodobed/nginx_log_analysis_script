#!/bin/bash

# The log file contains the following fields:
  # IP address
  # Date and time
  # Request method and path
  # Response status code
  # Response size
  # Referrer
  # User agent
# You are required to create a shell script that reads the log file and provides the following information:
  # Top 5 IP addresses with the most requests
  # Top 5 most requested paths
  # Top 5 response status codes
  # Top 5 user agents


# top 5 ip addresses
ip_addresses=$(
  cat ./sample_logs.log |\
  # $1 is the source ip
  awk '{print $1}' |\
  sort -h |\
  uniq -c |\
  sort -nr |\
  head -5 |\
  awk '{print $2 " - " $1 " occurences"}'
)


# # top 5 paths
paths=$(
  cat ./sample_logs.log |\
  cut -d '"' -f 2 |\
  cut -d ' ' -f 2 |\
  sort -h |\
  uniq -c |\
  sort -nr |\
  head -5 |\
  awk '{print $2 " - " $1 " occurences"}'
)


# top 5 response status codes
codes=$(
  cat ./sample_logs.log |\
  awk '{print $9}' |\
  sort -h |\
  uniq -c |\
  sort -nr |\
  head -5 |\
  awk '{print $2 " - " $1 " occurences"}'
)


# top 5 user agents
user_agents=$(
  head -150 ./sample_logs.log |\
  grep -oP '"[^"]*"(?=[^"]*$)' |\
  awk '{gsub(/"/, ""); print}' |\
  sort -R |\
  uniq -c |\
  sort -nr |\
  head -5 |\
  awk '{print $2 " - " $1 " occurences"}'
)


# display results
echo -e "Top 5 IP addresses with the most requests:\n$ip_addresses\n"
echo -e "Top 5 most requested paths:\n$paths\n"
echo -e "Top 5 response status codes:\n$codes\n"
echo -e "Top 5 user agents:\n$user_agents"
