// SPDX-License-Identifier: MIT
pragma solidity >=0.7.5;
pragma abicoder v2;

import {Test, console}   from "forge-std/Test.sol";
import {Deploy}          from "../script/Deploy.s.sol";
import {IUniswapV3Staker, UniswapV3Staker} from "../src/UniswapV3Staker.sol";
import {Parameters}      from "../src/Parameters.sol";

contract DeployTest is Test, Parameters {
  UniswapV3Staker uniswapV3Staker;

  function setUp() public {
    uniswapV3Staker = new Deploy().run();
  }

  // This makes sure we are forking mainnet and deploying the staking contract 
  function test_Sanity() public {
    assertTrue(uniswapV3Staker.maxIncentiveDuration() != 0);
  }

  function test_CreateIncentive() public {
    // TODO: give me some KEROSENE baby

    // IUniswapV3Staker.IncentiveKey memory key = IUniswapV3Staker.IncentiveKey({
    //   rewardToken: IERC20Minimal(MAINNET_KEROSENE),
    //   pool:        IUniswapV3Pool(POOL), 
    //   startTime:   START_TIME,
    //   endTime:     END_TIME, 
    //   refundee:    REFUNDEE
    // });

    // uniswapV3Staker.createIncentive(key, REWARD);
  }
}
