// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract InstitutionFactory is Ownable {
    event InstitutionCreated(
        uint256 indexed id,
        string name,
        address indexed addr
    );

    struct Institution {
        string name;
        string location;
        bool isValid;
    }

    mapping(address => uint256) public ownerToInstitution;
    mapping(uint256 => address) public institutionToOwner;

    Institution[] public institutions;

    /**
     * @dev Throws if called by any account who doesn't beloong to an Institution.
     */
    modifier onlyInstitution() {
        require(
            ownerToInstitution[_msgSender()] != 0,
            "Caller is not an institution owner"
        );
        _;
    }

    function createInstitution(string memory _name, string memory _location, address _address) public onlyOwner {
        institutions.push(Institution(_name, _location, true));

        uint256 id = institutions.length;
        ownerToInstitution[_address] = id;
        institutionToOwner[id] = _address;

        InstitutionCreated(id, _name, _address);
    }

    function editInstitution(uint256 _id, string memory _name, string memory _location) public onlyOwner {
        institutions[_id].name = _name;
        institutions[_id].location = _location;
    }

    function deleteInstitution(uint256 _id) public onlyOwner {
        Institution memory institution = institutions[_id];
        institution.isValid = false;
        ownerToInstitution[institutionToOwner[_id]] = 0;
        institutionToOwner[_id] = address(0);
    }

    function getInstitutionsCount() external view returns (uint256) {
        return institutions.length;
    }
}
