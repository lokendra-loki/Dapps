//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "../node_modules/hardhat/console.sol";

// import "hardhat/console.sol";

//Contract
contract ToDoContract {
    event AddTask(address recipient, uint256 taskId);
    event DeleteTask(uint256 taskId, bool isDeleted);

    //Single Task
    struct Task {
        uint256 id;
        string taskText;
        bool isDeleted;
    }

    //Array of Tasks
    Task[] private tasks;

    //Mapping each taskId to Address(owner)
    mapping(uint256 => address) taskToOwner;

    //Function to add a task
    function addTask(string memory taskText, bool isDeleted) external {
        uint256 taskId = tasks.length; //tasks array ko length is the id of new task
        tasks.push(Task(taskId, taskText, isDeleted)); //content of new task is pushed to tasks array
        taskToOwner[taskId] = msg.sender; //sender is mapped to taskId
        emit AddTask(msg.sender, taskId); //emit event AddTask
    }

    //Function to get tasks
}
