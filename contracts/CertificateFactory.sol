// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

import "./InstitutionFactory.sol";

contract CertificateFactory is InstitutionFactory {
    event CertificateCreated(
        uint256 indexed id,
        bytes32 digest,
        address indexed addr
    );

    // uint8 defaultHashFunction = 12; // sha-2
    // uint8 defaultDigestSize = 20; // 256-bits

    struct Certificate {
        string title;
        bytes32 digest;
        uint8 hashFunction;
        uint8 size;
        uint256 createdAt;
    }

    mapping(address => uint256[]) public studentToCertificates;
    mapping(address => uint256[]) public institutionToCertificates;

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

        uint256 id = certificates.length - 1;
        studentToCertificates[_address].push(id);
        institutionToCertificates[_msgSender()].push(id);

        CertificateCreated(id, _digest, _address);
    }
}
