#!/bin/zsh

for i in {0..2}
do
  echo "Deploying program_layer_$i"

  # save the output of the deploy command to a variable
  deploy_output=$(snarkos developer deploy "program_layer_$i.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_$i" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0)

  # echo output to terminal
  echo "$deploy_output"

  # extract the transaction ID from the deploy output
  tx_id=$(echo "$deploy_output" | sed -n 's/.*deployment \(at[0-9a-z]\{40,\}\).*/\1/p')
  echo "$tx_id"

  response_received=false
  while [[ "$response_received" == "false" ]]
    do
      response=$(curl -s "http://localhost:3033/testnet3/transaction/$tx_id")
      sleep 10
      echo "$response" | tr -d '\000-\031'
      echo "$response" | tr -d '\000-\031' | jq . >/dev/null 2>&1
      if [[ $? -eq 0 ]]; then
        echo "successful response for transaction $tx_id: $response"
        response_received=true
        break
      else
        echo "\nWaiting for response for transaction $tx_id..."
        sleep 10
        continue
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





# # save the output of the deploy command to a variable
# deploy_output=$(snarkos developer deploy "program_layer_0.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_0" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0)

# # echo output to terminal
# echo "$deploy_output"
# # echo "$deploy_output" > "deployment_response_0.txt"

# # extract the transaction ID from the deploy output
# tx_id=$(echo "$deploy_output" | sed -n 's/.*deployment \(at[0-9a-z]\{40,\}\).*/\1/p')
# echo "$tx_id"

# # testing
# response=$(curl -s "http://localhost:3033/testnet3/transaction/$tx_id")
# echo "$response"

# response_received=false
# while [[ "$response_received" == "false" ]]
#   do
#     response=$(curl -s "http://localhost:3033/testnet3/transaction/$tx_id")
#     echo "$response" | tr -d '\000-\031'
#     echo "$response" | tr -d '\000-\031' | jq . >/dev/null 2>&1
#     if [[ $? -eq 0 ]]; then
#       echo "successful response for transaction $tx_id: $response"
#       response_received=true
#       break
#     else
#       echo "\nWaiting for response for transaction $tx_id..."
#       sleep 10
#       continue
#     fi
#   done
