#! /bin/bash

# deploy 20 nested program layer programs
# you can modify the sleep to 30 seconds if you want it execute faster, 60 was just to ensure sufficient settlement time
for i in {0..19}
do
  echo "deploying program_layer_$i"
  snarkos developer deploy "program_layer_$i.aleo" --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --path "program_layer_$i" --broadcast "http://localhost:3033/testnet3/transaction/broadcast" --priority-fee 0
  echo letting deployments settle for a few seconds...
sleep 60
done

# # execute layer 19 which calls deeply nested child program to program 0
# snarkos developer execute program_layer_19.aleo do 2u32 --private-key "APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs" --query "http://localhost:3033" --broadcast "http://localhost:3033/testnet3/transaction/broadcast"

# # symptoms of execution
# # block production slowed down? but didn't stop
# # block production resumed
# # tried running these after execution program 19







