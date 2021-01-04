// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./InstitutionFactory.sol";

contract CertificateFactory is InstitutionFactory {

    event CertificateCreated(
        uint256 indexed id,
        bytes32 indexed digest,
        address indexed addr
    );

    struct Certificate {
        string title;
        bytes32 digest;
        uint8 hashFunction;
        uint8 size;
        uint256 createdAt;
    }

    mapping(uint256 => address) public certificateToInstitution;
    mapping(address => uint256) public institutionCertificatesCount;

    mapping(uint256 => address) public certificateToStudent;
    mapping(address => uint256) public studentCertificatesCount;

    Certificate[] public certificates;

    function createCertificate(
        string memory _title,
        bytes32 _digest,
        uint8 _hashFunction,
        uint8 _size,
        address _address
    ) public {
        Certificate memory cert = Certificate(
            _title,
            _digest,
            _hashFunction,
            _size,
            block.timestamp
        );
        certificates.push(cert);
        uint256 id = certificates.length;

        certificateToInstitution[id] = msg.sender;
        institutionCertificatesCount[msg.sender]++;

        certificateToStudent[id] = _address;
        studentCertificatesCount[_address]++;

        CertificateCreated(id, _digest, _address);
    }

    function getCertificatesCount() external view returns (uint256) {
        return certificates.length;
    }

    function getCertificatesByInstitution(address _address) external view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](institutionCertificatesCount[_address]);

        uint256 counter = 0;
        for (uint256 i = 0; i < certificates.length; i++) {
            if (certificateToInstitution[i] == _address) {
                result[counter] = i;
                counter++;
            }
        }

        return result;
    }

    function getCertificatesByStudent(address _address) external view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](studentCertificatesCount[_address]);

        uint256 counter = 0;
        for (uint256 i = 0; i < certificates.length; i++) {
            if (certificateToStudent[i] == _address) {
                result[counter] = i;
                counter++;
            }
        }

        return result;
    }
}
