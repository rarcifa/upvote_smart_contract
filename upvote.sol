// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Upvote {
    
    uint256 private upvotes;
    uint256 private sumScore;
    uint256 private meanAverageScore;
    bool private qualityContent;
    
    struct Upvoter {
        uint completeness; // by completeness
        uint correctness; // by correctness
        uint authenticity; // by authenticity
        uint relevancy; // by relevancy
        bool upvoted;  // if true, that person already upvoted
        address delegate; // person delegated to
    }
    
    mapping(address => Upvoter) public users;
    
    function upvote() public {
        Upvoter storage sender = users[msg.sender];
        require(!sender.upvoted, "Already upvoted.");
        sender.upvoted = true;
        
        // struct values from 0-5
        uint Cm = 2;
        uint Cr = 2;
        uint r = 2;
        uint a = 2;
        
        // sender values from struct
        sender.completeness = Cm;
        sender.correctness = Cr;
        sender.relevancy = r;
        sender.authenticity = a;
        
        upvotes += 1; // add upvote
        // Mean average = sum of values / number of values
        sumScore += 
            sender.completeness + 
            sender.correctness + 
            sender.relevancy + 
            sender.authenticity;
        
        meanAverageScore = sumScore / upvotes;
        
        // condition average sum needs to be above 12
        if (meanAverageScore >= 12) {
            qualityContent = true; // update the quality value to true
        } else {
            qualityContent = false;
        }
    }
    
    function getUpvotes() public view returns (uint256) {
        return upvotes;
    }
    
    function getMeanAverageScore() public view returns (uint256) {
        return meanAverageScore;
    }

    function getQualityStatus() public view returns (bool) {
        return qualityContent;
    }
}