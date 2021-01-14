// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract crowdfunding {
    struct investor {
        address payable addr;
        uint amount;
    }

    struct funding {
        address payable creator_addr;
        address payable[] participators_addr;
        mapping(uint => investor) id_to_investor;

        uint start_time;
        uint end_time;
        string intro;
        uint amount_all;
        uint amount_get;
    }

    struct request {
        string purpose;
        uint amount;
    }
}