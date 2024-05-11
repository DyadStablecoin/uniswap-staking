// SPDX-License-Identifier: MIT
pragma solidity >=0.7.5;
pragma abicoder v2;

import {Script, console} from "forge-std/Script.sol";
import {IUniswapV3Staker, UniswapV3Staker} from "../src/UniswapV3Staker.sol";
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol';
import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '@uniswap/v3-core/contracts/interfaces/IERC20Minimal.sol';
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';

import {Parameters} from "../src/Parameters.sol";

contract Deploy is Script, Parameters {

  uint MAX_INCENTIVE_START_LEAD_TIME = 7   days;  
  uint MAX_INCENTIVE_DURATION        = 365 days; // REVIEW!

  address UNI_FACTORY      = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
  address POSITION_MANAGER = 0xC36442b4a4522E871399CD717aBDD847Ab11FE88;

  address POOL       = 0x680B3eC4BE81d19772B7295a3BaBe00dA2471c16; // DYAD/USDC
  uint    START_TIME = block.timestamp + 1 hours; // REVIEW!
  uint    END_TIME   = START_TIME + 60 days;      // REVIEW!
  address REFUNDEE   = 0xDeD796De6a14E255487191963dEe436c45995813;

  uint REWARD = 100_000; // REVIEW! // KEROSENE

  function run() public returns (UniswapV3Staker) {
    vm.startBroadcast();  // ----------------------

    UniswapV3Staker uniswapV3Staker = new UniswapV3Staker(
      IUniswapV3Factory          (UNI_FACTORY),
      INonfungiblePositionManager(POSITION_MANAGER),
      MAX_INCENTIVE_START_LEAD_TIME, 
      MAX_INCENTIVE_DURATION
    );

    IUniswapV3Staker.IncentiveKey memory key = IUniswapV3Staker.IncentiveKey({
      rewardToken: IERC20Minimal(MAINNET_KEROSENE),
      pool:        IUniswapV3Pool(POOL), 
      startTime:   START_TIME,
      endTime:     END_TIME, 
      refundee:    REFUNDEE
    });

    //---- this needs to be called by the multi sig!
    //---- or whoever holds the kerosene
    // uniswapV3Staker.createIncentive(key, REWARD);

    vm.stopBroadcast();  // ----------------------------

    return uniswapV3Staker;
  }
}
