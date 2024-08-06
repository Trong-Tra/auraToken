// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract AuraStaking is Ownable {
    /**
     * @dev error
     */
    error InvalidStakingAmount();
    error StakeFailed();

    /**
     * @dev event
     */
    event staked(address staker, uint256 amount);

    /**
     * @dev contract variable
     */

    IERC20 public stakingToken;
    uint256 public rewardRate;

    struct Stake {
        uint256 amount;
        uint256 stakeWen;
    }
    mapping(address => Stake) public stakes;

    /**
     * @param _stakingToken token address
     * @param _rewardRate reward rate for staking
     */
    constructor(
        address _stakingToken,
        uint256 _rewardRate
    ) Ownable(msg.sender) {
        stakingToken = IERC20(_stakingToken);
        rewardRate = _rewardRate;
    }

    function stake(uint256 stakeAmount) public {
        if (stakeAmount <= 0) revert InvalidStakingAmount();

        bool success = stakingToken.transferFrom(
            msg.sender,
            address(this),
            stakeAmount
        );

        if (!success) revert StakeFailed();

        stakes[msg.sender].amount += stakeAmount;
        if (stakes[msg.sender].stakeWen == 0)
            stakes[msg.sender].stakeWen = block.timestamp;

        emit staked(msg.sender, stakes[msg.sender].amount);
    }
}
