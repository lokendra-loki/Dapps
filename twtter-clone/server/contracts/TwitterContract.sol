//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract TwitterContract {
    event AddTweet(address recipient, uint256 tweetId);
    event DeleteTweet(uint256 tweetId, bool isDeleted);

    //tweet
    struct Tweet {
        uint256 id; //each tweet has an id
        address username; //the address of the user who posted the tweet
        string tweetTxt; //the text of the tweet
        bool isDeleted; //is the tweet deleted?
    }

    //privately store the tweet
    Tweet[] private tweets;

    //mapping of tweet id to wallet address
    mapping(uint256 => address) tweetToOwner;

    //method to be called by frontend when trying to post a tweet
    function addTweet(string memory tweetTxt, bool isDeleted) external {
        uint256 tweetId = tweets.length; //creating tweetID based on the length of the tweet array
        tweets.push(Tweet(tweetId, msg.sender, tweetTxt, isDeleted)); //pushing the tweet to the array //msg.sender is the wallet address of the user who is posting the tweet
        tweetToOwner[tweetId] = msg.sender; //mapping the tweetId to the wallet address of the user who is posting the tweet
        emit AddTweet(msg.sender, tweetId); //emitting the event //This means add a new block in our blockcjhain with these data
    }

    //method to get all the tweets
    function getAllTweets() external view returns (Tweet[] memory) {
        Tweet[] memory temporary = new Tweet[](tweets.length);

        //show only those tweets  that are not deleted
        uint256 counter = 0;
        for (uint256 i = 0; i < tweets.length; i++) {
            if (tweets[i].isDeleted == false) {
                // if (!tweets[i].isDeleted)
                temporary[counter] = tweets[i];
                counter++;
            }
        }

        Tweet[] memory result = new Tweet[](counter);
        for (uint256 i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }
        return result;
    }

    //methods to get only my tweets
    function getMyTweets() external view returns (Tweet[] memory) {
        Tweet[] memory temporary = new Tweet[](tweets.length);

        //show only those tweets  that are not deleted
        uint256 counter = 0;
        for (uint256 i = 0; i < tweets.length; i++) {
            if (tweetToOwner[i] == msg.sender && tweets[i].isDeleted == false) {
                temporary[counter] = tweets[i];
                counter++;
            }
        }

        Tweet[] memory result = new Tweet[](counter);
        for (uint256 i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }
        return result;
    }

    //method to delete a tweet
    //delete is a write operation so it takes some etherium to delete a tweet but read operations are free
    //for every write we need to create a new block in the blockchain
    function deleteTweet(uint256 tweetId, bool isDeleted) external {
        //only delete my tweets
        if (tweetToOwner[tweetId] == msg.sender) {
            tweets[tweetId].isDeleted = isDeleted;
            emit DeleteTweet(tweetId, isDeleted);
        }
    }
}

