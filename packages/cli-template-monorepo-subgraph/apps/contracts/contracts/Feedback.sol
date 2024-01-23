//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@semaphore-protocol/contracts/interfaces/ISemaphore.sol";

contract Feedback {
    ISemaphore public semaphore;

    uint256 public groupId;

    constructor(ISemaphore _semaphore, uint256 _groupId) {
        semaphore = _semaphore;
        groupId = _groupId;

        semaphore.createGroup(groupId, address(this));
    }

    function joinGroup(uint256 identityCommitment) external {
        semaphore.addMember(groupId, identityCommitment);
    }

    function sendFeedback(
        uint256 merkleTreeDepth,
        uint256 merkleTreeRoot,
        uint256 nullifier,
        uint256 feedback,
        uint256[8] calldata proof
    ) external {
        semaphore.validateProof(groupId, merkleTreeDepth, merkleTreeRoot, nullifier, feedback, groupId, proof);
    }
}
