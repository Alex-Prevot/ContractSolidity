pragma solidity >=0.7.0 <0.9.0;

contract MyContract {

    string[] public name;

    function setArray(string memory _NewName) public {
        name.push(_NewName);
    }

    function getArray() public view returns (string[] memory) {
        return name;
    }
}

contract UserCreate {

    struct User {
        string name;
        uint password;
    }

    User[] public users;

    function _createUser(string memory _name, uint _password) private {
        users.push(User(_name, _password));
    }

    function _createRandomPassword(string memory _name) private view returns (uint) {
        uint _password = uint(keccak256(abi.encodePacked(_name)));
        return _password;
    }

    function createUser(string memory _name) public {
        uint password = _createRandomPassword(_name);
        _createUser(_name, password);
    }

    function getUser() public view returns (User[] memory) {
        User[] memory allUsers = new User[](users.length);
        for (uint i = 0; i < users.length; i++) {
            User storage allUser = users[i];
            allUsers[i] = allUser;
        }
        return allUsers;
    }
}