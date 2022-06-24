const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Twitter Contract", function () {
  //Twitter Contract is the test name
  let Twitter;
  let twitter;
  let owner;
  const NUM_TOTAL_NOT_MY_TWEETS = 5;
  const NUM_TOTAL_MY_TWEETS = 3;
  let totalTweets;
  let totalMyTweets;

  //before each unit test run the following code
  beforeEach(async function () {
    Twitter = await ethers.getContractFactory("TwitterContract"); //instance of the the TwitterContract
    [owner, address1, address2] = await ethers.getSigners(); //A Signer in Ethers.js is an object that represents an Ethereum account. It's used to send transactions to contracts and other accounts
    //we need few addresses to test the contract so we create few accounts
    twitter = await Twitter.deploy(); //deploy the contract

    totalTweets = [];
    totalMyTweets = [];

    for (let i = 0; i < NUM_TOTAL_NOT_MY_TWEETS; i++) {
      let tweet = {
        tweetTxt: "Random text with id " + i,
        username: address1,
        isDeleted: false,
      };
      await twitter.connect(address1).addTweet(tweet.tweetTxt, tweet.isDeleted); //add tweet to the contract
      totalMyTweets.push(tweet);
    }

    for (let i = 0; i < NUM_TOTAL_MY_TWEETS; i++) {
      let tweet = {
        tweetTxt: "Random text with id " + (i + NUM_TOTAL_NOT_MY_TWEETS),
        username: address1,
        isDeleted: false,
      };
      await twitter.connect(address1).addTweet(tweet.tweetTxt, tweet.isDeleted); //add tweet to the contract
      totalMyTweets.push(tweet);
    }
  });

  //Testing add tweet method
  describe("Add Tweet", function () {
    it("Should should add a tweet to the blockchain", async function () {
      let tweet = {
        tweetTxt: "New Tweet",
        isDeleted: false,
      };
      
    });
  });
});
