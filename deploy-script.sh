#!/bin/zsh

for i in {0..2}
do
  echo "Deploying program_layer_$i"

  # save the output of the deploy command to a variable
  deploy_output=$(snarkos developer deploy "program_layer_$i.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_$i" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0)

  # echo output to terminal
  echo "$deploy_output"
  # echo "$deploy_output" > "deployment_response_0.txt"

  # extract the transaction ID from the deploy output
  tx_id=$(echo "$deploy_output" | sed -n 's/.*deployment \(at[0-9a-z]\{40,\}\).*/\1/p')
  echo "$tx_id"

  # initialize a variable to control the while loop
  response_received=false

  # loop until the transaction response is received
  while [[ "$response_received" == "false" ]]
  do
    response=$(curl "http://localhost:3033/testnet3/transaction/broadcast/$tx_id")

    if [[ "$response" == "Invalid URL: invalid checksum" ]]; then
      echo "invalid response for transaction $tx_id: $response"
      echo "trying again"
      sleep 10
      break
    elif [[ "$response" == "Something went wrong: Missing transaction for ID $tx_id:" ]]; then
      echo "something went wrong: Missing transaction for ID $tx_id:"
      echo "trying again"
      sleep 10
      break
    elif [[ ! -z "$response" ]]; then
      echo "Successful response for transaction $tx_id: $response"
      response_received=true
    else
      echo "waiting for response for transaction $tx_id..."
      echo "trying again"
      sleep 10
    fi
  done

  echo "Moving to the next deployment..."
done

echo "All deployments are done."















# #! /bin/bash

# # deploy 20 nested program layer programs
# # you can modify the sleep to 30 seconds if you want it execute faster, 60 was just to ensure sufficient settlement time
# for i in {0..19}
# do
#   echo "deploying program_layer_$i"
#   snarkos developer deploy "program_layer_$i.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_$i" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0
#   echo letting deployments settle for a few seconds...
# sleep 60
# done

# # execute layer 19 which calls deeply nested child program to program 0
# # snarkos developer execute program_layer_19.aleo do 2u32 --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --broadcast "http://localhost:3033/testnet3/transaction/broadcast"

# # symptoms of execution
# # block production slowed down? but didn't stop
# # block production resumed
# # tried running these after execution program 19



# # issue with deployment of program 4 & 5 but not 3 (or transaction missing)
# # temporary fix where we look for successful transaction response before moving on, else stop, so we don't waste time

# for i in {0..2}
# do
#   echo "deploying program_layer_$i"
# snarkos developer deploy "program_layer_$i.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_$i" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0
#   echo letting deployments settle for a few seconds...
# sleep 60
# done









# #!/bin/zsh

# for i in {0..2}
# do
#   echo "deploying program_layer_$i"

#   # save the output of the deploy command to a variable
#   deploy_output=$(snarkos developer deploy "program_layer_$i.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_$i" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0)

#   # echo output to terminal and save to file (optional)
#   echo "$deploy_output"
#   # echo "$deploy_output" > "deployment_response_$i.txt"

#   # extract the transaction ID from the deploy output
#   tx_id=$(echo "$deploy_output" | grep -o 'at[0-9a-z]\+')
#   echo "$tx_id"

#   # initialize a variable to control the while loop
#   response_received=false

#   # loop until the transaction response is received
#   while [ "$response_received" == "false" ]
#   do
#     # check the transaction status
#     response=$(curl -s "http://localhost:3033/testnet3/transaction/broadcast/$tx_id")

#     # if the response is not empty, set the flag to true and break the loop
#     if [[ "$response" == *"Invalid URL: invalid checksum"* ]]; then
#       echo "invalid response for transaction $tx_id: $response"
#       break
    
#     # if response doesn't contain the error message, assume valid
#     elif [ ! -z "$response" ]; then
#       echo "successful response for transaction $tx_id: $response"
#       response_received=true
#       break

#     else
#       echo "waiting for response for transaction $tx_id..."
#       sleep 5

#     fi
#   done
  
#   echo "moving to the next deployment..."
# done

# echo "all deployments are done"














# # save the output of the deploy command to a variable
# deploy_output=$(snarkos developer deploy "program_layer_0.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_0" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0)

# # echo output to terminal
# echo "$deploy_output"
# echo "$deploy_output" > "deployment_response_0.txt"

# # extract the transaction ID from the deploy output
# tx_id=$(echo "$deploy_output" | sed -n 's/.*deployment \(at[0-9a-z]\{40,\}\).*/\1/p')
# echo "$tx_id"

# echo curl "http://localhost:3033/testnet3/transaction/$tx_id"