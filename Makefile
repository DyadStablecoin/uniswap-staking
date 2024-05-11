include .env

test:
	echo "Testing"

forkTest:
	echo "Forking mainnet!"
	forge test \
		-vvv \
		--fork-url $(RPC) $(fork-block-number)


deploy:
		forge script script/Deploy.s.sol \
		--rpc-url $(MAINNET_RPC) \
		--sender 0xEEB785F7700ab3EBbD084CE22f274b4961950d9A \
		--broadcast \
		--verify \
		-i 1 \
		-vvvv # \
		# --via-ir \
		# --optimize
