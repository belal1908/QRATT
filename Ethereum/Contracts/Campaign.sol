// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CampaignFactory{
    address[] deployedCampaign; 
    function createCampaign(uint contribution) public{
        Campaign newCampaign = new Campaign(contribution,msg.sender);
        deployedCampaign.push(address(newCampaign));
    }
    function getDeployedCampaign() public view returns(address[] memory){
        return deployedCampaign;

    }
}

contract Campaign{

    struct Request{
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint approvalCount;
    }

    Request[] public requests; 
    address public manager;
    uint public minimumContribution;
    mapping(address=>bool) public approvers;
    uint public approversCount;
    mapping(address => bool) public didApprove;

    modifier restricted{
        require(msg.sender == manager);
        _;
    }
    
    constructor(uint minimum, address owner){
        manager = owner;
        minimumContribution = minimum;
    }

    function contribute() public payable{
        require(msg.value > minimumContribution);
        approvers[msg.sender] = true;
        approversCount++;
    }

    function createRequest(string memory description,uint value,address payable recipient) public restricted{
        Request memory newRequest = Request({description:description,value:value,recipient:recipient,complete:false,approvalCount:0});
        requests.push(newRequest);

    }
    function approveRequest(uint index) public{
        require(approvers[msg.sender]);
        require(!didApprove[msg.sender]);

        didApprove[msg.sender] = true;
        requests[index].approvalCount++;
    }
    function finalizeRequest(uint index) public restricted{
        Request storage request = requests[index];
        require(request.approvalCount>approversCount/2);
        require(!request.complete);

        request.recipient.transfer(request.value);
        request.complete = true;

    }
    function getSummary() public view returns(uint,uint,uint,uint,address) {
        return(minimumContribution,address(this).balance,requests.length,approversCount,manager);
    }
    function getRequestCount() public view returns(uint){
        return requests.length;
    }

}