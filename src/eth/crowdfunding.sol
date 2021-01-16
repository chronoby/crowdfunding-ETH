// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

contract crowdfunding {
    enum Status { processing, success, failed }

    struct Investor {
        address payable addr; 
        uint amount;
    }

    struct Funding {
        address payable creator;
        uint num_investors;
        mapping(uint => Investor) investors;

        uint start_time;
        uint end_time;
        string info;
        uint amount_goal;
        uint amount_get;

        Status status; // 0: processing 1: success 2: failed

        uint num_requests;
        mapping(uint => Request) requests;
    }

    struct Request {
        string purpose;
        uint amount;
        mapping(uint => uint) reply_status; // investor's reply: 
                                            //0: no reply 1: agree 2: disagree
        Status status;
        uint pass_amount;
        uint nopass_amount;
    }

    uint num_funding;
    mapping(uint => Funding) fundings; 

    function create_funding(string calldata info, uint e_time, uint amount) public returns(uint fundingID) {
        require(e_time > block.timestamp);

        fundingID = num_funding++;

        Funding storage tmp = fundings[fundingID];
        tmp.info = info;
        tmp.creator = msg.sender;
        tmp.start_time = block.timestamp;
        tmp.end_time = e_time;
        tmp.amount_goal = amount;
    }

    function participant_funding(uint fundingID) public payable {
        require(fundingID >= 0 && fundingID < num_funding);
        require(fundings[fundingID].status == Status.processing);
        require(msg.value > 0 && msg.value <= fundings[fundingID].amount_goal - fundings[fundingID].amount_get);

        Funding storage tmp = fundings[fundingID];
        tmp.investors[tmp.num_investors++] = Investor({addr: msg.sender, amount: msg.value});
        tmp.amount_get += msg.value;
    }

    function return_eth(uint fundingID) public {
        require(fundingID >= 0 && fundingID < num_funding);

        Funding storage tmp = fundings[fundingID];
        for(uint i = 0; i < tmp.num_investors; i++) {
            if(tmp.investors[i].addr == msg.sender) {
                tmp.investors[i].addr.transfer(tmp.investors[i].amount);
                tmp.amount_get -= tmp.investors[i].amount;
                tmp.investors[i].amount = 0;
            }
        }
    }

    function check_goal_reached(uint fundingID) public returns (bool reached) {
        Funding storage tmp = fundings[fundingID];
        if(tmp.amount_get < tmp.amount_goal)
            return false;
        uint amount = tmp.amount_get;
        tmp.amount_get = 0;
        tmp.creator.transfer(amount);
        return true;
    }

    function create_request(uint fundingID, string calldata p, uint a) public {
        require(fundingID >= 0 && fundingID < num_funding);
        require(fundings[fundingID].status == Status.success);
        require(a <= fundings[fundingID].amount_get);
        require(msg.sender == fundings[fundingID].creator);

        Funding storage tmp = fundings[fundingID];
        uint requestID = tmp.num_requests++;
        Request storage request = tmp.requests[requestID];
        request.amount = a;
        request.purpose = p;
    }

    function reply(uint fundingID, uint requestID, bool agree) public {
        require(fundingID >= 0 && fundingID < num_funding);
        require(requestID >= 0 && requestID < fundings[fundingID].num_requests);
        require(fundings[fundingID].requests[requestID].status == Status.processing);

        for(uint i = 0; i < fundings[fundingID].num_investors; i++) {
            if(fundings[fundingID].investors[i].addr == msg.sender) {
                if(agree) {
                    fundings[fundingID].requests[requestID].reply_status[i] == 1;
                    fundings[fundingID].requests[requestID].pass_amount += fundings[fundingID].investors[i].amount;
                } else {
                    fundings[fundingID].requests[requestID].reply_status[i] == 2;
                    fundings[fundingID].requests[requestID].nopass_amount += fundings[fundingID].investors[i].amount;
                }
            }
        }
        check_pass(fundingID, requestID);
    }

    function check_pass(uint fundingID, uint requestID) public{
        if(fundings[fundingID].requests[requestID].pass_amount >= fundings[fundingID].amount_goal / 2) {
            fundings[fundingID].requests[requestID].status = Status.success;
            fundings[fundingID].creator.transfer(fundings[fundingID].requests[requestID].amount);
        } else if(fundings[fundingID].requests[requestID].nopass_amount >= fundings[fundingID].amount_goal / 2) {
            fundings[fundingID].requests[requestID].status = Status.failed;
        }
    }
}