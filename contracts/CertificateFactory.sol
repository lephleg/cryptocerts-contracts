// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

import "./InstitutionFactory.sol";

contract CertificateFactory is InstitutionFactory {
    
    event CertificateCreated(uint indexed id, bytes32 digest, address indexed addr);

    // uint8 defaultHashFunction = 12; // sha-2
    // uint8 defaultDigestSize = 20; // 256-bits

    struct Certificate {
      bytes32 digest;
      uint8 hashFunction;
      uint8 size;
      uint createdAt;
    }
    
    mapping (address => uint[]) public studentToCertificates;
    mapping (address => uint[]) public institutionToCertificates;

    Certificate[] public certificates;
    
    function createCertificate(bytes32 _digest, uint8 _hashFunction, uint8 _size, address _address) public {
        Certificate memory cert = Certificate(_digest, _hashFunction, _size, block.timestamp);
        certificates.push(cert);

        uint id = certificates.length - 1;
        studentToCertificates[_address].push(id);
        institutionToCertificates[_msgSender()].push(id);

        CertificateCreated(id, _digest, _address);
    }
}
