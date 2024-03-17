// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LosslessBettingVault is ERC4626, ReentrancyGuard, Ownable {
	using SafeERC20 for IERC20;

	struct Bet {
		uint256 amount;
		bool onTeamA;
		bool claimed;
	}

	enum Stage {
		Betting,
		Staking,
		Finished
	}
	Stage public stage = Stage.Betting;

	bool public teamAWins;
	uint256 public loserStakingPeriodEnd;

	mapping(address => Bet) public bets;
	uint256 public totalStakedTeamA;
	uint256 public totalStakedTeamB;
	uint256 private _totalYield;

	// Duration of the loser staking period in seconds, e.g., 30 days.
	uint256 public constant LOSER_STAKING_PERIOD = 30 days;

	event BetPlaced(address indexed bettor, uint256 amount, bool onTeamA);
	event WinnersDeclared(bool teamAWins);
	event RewardsClaimed(address indexed bettor, uint256 reward);

	constructor(IERC20 asset) ERC4626(asset) {}

	// Place a bet on Team A or Team B.
	function placeBet(uint256 amount, bool onTeamA) external nonReentrant {
		require(stage == Stage.Betting, "Betting stage is over");
		require(amount > 0, "Cannot bet zero amount");

		_mint(msg.sender, amount); // Mint ERC4626 shares for the bettor equal to the amount.

		Bet storage bet = bets[msg.sender];
		bet.amount += amount;
		bet.onTeamA = onTeamA;
		bet.claimed = false;

		if (onTeamA) {
			totalStakedTeamA += amount;
		} else {
			totalStakedTeamB += amount;
		}

		emit BetPlaced(msg.sender, amount, onTeamA);
	}

	// Called by the admin to declare the winning team and start the loser staking period.
	function declareWinners(bool _teamAWins) external onlyOwner {
		require(stage == Stage.Betting, "Not in betting stage");
		stage = Stage.Staking;
		loserStakingPeriodEnd = block.timestamp + LOSER_STAKING_PERIOD;
		this.teamAWins = _teamAWins;
		emit WinnersDeclared(teamAWins);
	}

	// Allows users to claim their rewards after the staking period.
	function claimReward() external nonReentrant {
		require(stage == Stage.Staking, "Staking period not over yet");
		require(
			block.timestamp > loserStakingPeriodEnd,
			"Loser staking period is not over yet"
		);
		require(bets[msg.sender].amount > 0, "No bet placed");
		require(!bets[msg.sender].claimed, "Reward already claimed");

		Bet storage userBet = bets[msg.sender];
		userBet.claimed = true;

		uint256 userAmount = userBet.amount;
		bool isWinner = (userBet.onTeamA == teamAWins);
		uint256 reward = isWinner
			? calculateWinnerReward(msg.sender)
			: userAmount;

		// Update internal accounting for yield distribution before transferring rewards.
		if (isWinner) {
			_totalYield -= (reward - userAmount);
		}

		_burn(msg.sender, userAmount); // Burn the bettor's shares.
		asset.safeTransfer(msg.sender, reward); // Transfer the original bet plus yield if the user won.

		emit RewardsClaimed(msg.sender, reward);
	}

	// Calculate the reward for a winning bet.
	function calculateWinnerReward(
		address bettor
	) private view returns (uint256) {
		uint256 userBetAmount = bets[bettor].amount;
		uint256 totalStaked = teamAWins ? totalStakedTeamA : totalStakedTeamB;
		// Calculate the user's share of the total yield.
		uint256 userShareOfYield = (_totalYield * userBetAmount) / totalStaked;
		return userBetAmount + userShareOfYield;
	}

	// Override the totalAssets function to include both the staked amount and any generated yield.
	function totalAssets() public view override returns (uint256) {
		return asset.balanceOf(address(this)) + _totalYield;
	}

	// Admin function to add yield to the vault. This simulates yield generation over the staking period.
	function addYield(uint256 amount) external onlyOwner {
		require(stage == Stage.Staking, "Not in staking stage");
		_totalYield += amount;
		asset.safeTransferFrom(msg.sender, address(this), amount);
	}

	// Transition to the finished stage after the staking period and yield distribution are complete.
	function finishStaking() external onlyOwner {
		require(stage == Stage.Staking, "Not in staking stage");
		require(
			block.timestamp > loserStakingPeriodEnd,
			"Loser staking period is not over yet"
		);
		stage = Stage.Finished;
	}

	// Optional: Implement withdrawal logic for losers after the loser staking period, if desired.
}
