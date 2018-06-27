pragma solidity 0.4.24;


contract AntiFactor {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    struct User {
        address publickey;
    }

    //Hash of the fingerprint+pubic address with public key
    mapping(deviceFingeprintHash => User) deviceUserMappings;

    //Add device signature hash and link to public address
    function update(address userPublicAddress, string deviceFingeprintHash) public payable {
        require(msg.sender == owner);
        string key = userPublicAddress+deviceFingeprintHash;
        deviceUserMappings[key] = User(deviceFingeprintHash);
    }

    //Pay out to the toAddress (kids address) from the Contract address
    function validate(address userPublicAddress, string deviceFingeprintHash) public constant returns(bool){
        string key = userPublicAddress+deviceFingeprintHash;
        if (deviceUserMappings[key].publickey == userPublicAddress) {
          return true;
        }
        return false;
    }
}
