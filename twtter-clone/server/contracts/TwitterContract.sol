//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract TwitterContract {
    //tweet
    struct Tweet {
        uint256 id; //each tweet has an id
        address username; //the address of the user who posted the tweet
        string tweetTxt; //the text of the tweet
        bool isDeleted; //is the tweet deleted?
    }

    //privately store the tweet
    Tweet[] private tweets;

    //mapping of twit id to wallet address
    mapping(uint256 => address) tweetToOwner;
}
