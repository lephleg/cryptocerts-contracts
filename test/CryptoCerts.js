const CryptoCerts = artifacts.require("CryptoCerts");

contract("CryptoCerts", accounts => {

    const admin = accounts[0];
    const institution = accounts[1];
    const student = accounts[2];
    const institutionName = "University of Macedonia";
    const digest = "311fe3feed16b9cd8df0f8b1517be5cb86048707df4889ba8dc37d4d68866d02"; // "yolo"
    const hashFunction = 12; // sha-2
    const size = 20; // 256-bits

    it("should be able to create a new institution", () => {
        CryptoCerts.deployed()
            .then(instance => instance.createInstitution.call(institutionName, institution, { from: admin }))
            .then(results => {
                assert.equal(results.receipt.status, true);
                assert.equal(results.logs[0].args.name, institutionName);
                assert.equal(results.logs[0].args.addr, institution);
            })
    });

    it("should be able to create a new certificate", () => {
        CryptoCerts.deployed()
            .then(instance => instance.createCertificate.call(digest, hashFunction, size, student, { from: institution }))
            .then(results => {
                assert.equal(results.receipt.status, true);
                assert.equal(results.logs[0].args.digest, digest);
                assert.equal(results.logs[0].args.addr, student);
            })
    });
});