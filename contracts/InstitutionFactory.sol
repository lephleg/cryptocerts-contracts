// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract InstitutionFactory is Ownable {
    
    event InstitutionCreated(uint indexed id, string indexed name, address indexed addr);
    
    struct Institution {
        string name;
        bool isValid;
    }
    
    mapping (address => uint) public ownerToInstitution;
    mapping (uint => address) public institutionToOwner;
    
    Institution[] public institutions;

    /**
     * @dev Throws if called by any account who doesn't beloong to an Institution.
     */
    modifier onlyInstitution() {
        require(ownerToInstitution[_msgSender()] != 0, "Caller is not an institution owner");
        _;
    }
    
    function createInstitution(string memory _name, address _address) public onlyOwner {
        institutions.push(Institution(_name, true));

        uint id = institutions.length - 1;
        ownerToInstitution[_address] = id;
        institutionToOwner[id] = _address;
        
        InstitutionCreated(id, _name, _address);
    }
    
    function editInstitution(uint _id, string memory _name) public onlyOwner {
        institutions[_id].name = _name;
    }
    
    function deleteInstitution(uint _id) public onlyOwner {
        Institution memory institution = institutions[_id];
        institution.isValid = false;
        ownerToInstitution[institutionToOwner[_id]] = 0;
        institutionToOwner[_id] = address(0);
    }
}
