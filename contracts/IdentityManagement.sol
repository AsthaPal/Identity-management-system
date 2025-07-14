// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16;

contract IdentityManagement {

    address ContractOwner;

    constructor() public {
        ContractOwner = msg.sender;
    }

    struct UserInfo {
        string FullName;
        string EmailID;
        uint MobileNo;
    }

    struct UserDL {
        string DL_No;
        string DL_Name;
        string DL_DOB; 
        string DL_Address;
    }

    struct DLRequest {
        string RequestedBy;
        uint DL_No;
        uint DL_Name;
        uint DL_DOB;
        uint DL_Address;
        uint DL_OverAll_Status;
    }

    mapping(address => UserInfo[]) UserMap;
    mapping(address => UserDL[]) UserDLMap;
    mapping(address => DLRequest[]) DLRequestMap;

    function AddUser(address UserAddress, string memory _FullName, string memory _EmailID, uint MobileNo) public {
        UserMap[UserAddress].push(UserInfo(_FullName, _EmailID, MobileNo));
    }

    function AddUserDL(
        address UserAddress,
        string memory _DL_No,
        string memory _DL_Name,
        string memory _DL_DOB,
        string memory _DL_Address
    ) public {
        UserDLMap[UserAddress].push(UserDL(_DL_No, _DL_Name, _DL_DOB, _DL_Address));
    }

    function AddDLRequest(
        address UserAddress,
        string memory RequestedBy,
        uint DL_No,
        uint DL_Name,
        uint DL_DOB,
        uint DL_Address,
        uint DL_OverAll_Status
    ) public {
        DLRequestMap[UserAddress].push(DLRequest(RequestedBy, DL_No, DL_Name, DL_DOB, DL_Address, DL_OverAll_Status));
    }

    function ViewDLRequestLength(address UserAddress) public view returns (uint) {
        return DLRequestMap[UserAddress].length;
    }

    function ViewDLRequestHeader(address UserAddress, uint RequestIndex) public view returns (string memory RequestedBy, uint DL_OverAll_Status) {
        DLRequest storage ThisDLRequest = DLRequestMap[UserAddress][RequestIndex];
        return (ThisDLRequest.RequestedBy, ThisDLRequest.DL_OverAll_Status);
    }

    function ViewDLRequestDetail(address UserAddress, uint RequestIndex)
        public
        view
        returns (
            string memory RequestedBy,
            uint DL_No,
            uint DL_Name,
            uint DL_DOB,
            uint DL_Address,
            uint DL_OverAll_Status
        )
    {
        DLRequest storage ThisDLRequest = DLRequestMap[UserAddress][RequestIndex];
        return (
            ThisDLRequest.RequestedBy,
            ThisDLRequest.DL_No,
            ThisDLRequest.DL_Name,
            ThisDLRequest.DL_DOB,
            ThisDLRequest.DL_Address,
            ThisDLRequest.DL_OverAll_Status
        );
    }

    function UpdateRequestStatus(
        address UserAddress,
        uint RequestIndex,
        uint DL_No,
        uint DL_Name,
        uint DL_DOB,
        uint DL_Address,
        uint DL_OverAll_Status
    ) public {
        DLRequest storage ThisRequest = DLRequestMap[UserAddress][RequestIndex];
        ThisRequest.DL_No = DL_No;
        ThisRequest.DL_Name = DL_Name;
        ThisRequest.DL_DOB = DL_DOB;
        ThisRequest.DL_Address = DL_Address;
        ThisRequest.DL_OverAll_Status = DL_OverAll_Status;
    }

    function viewUser(address UserAddress, uint UserIndex) public view returns (string memory FullName, string memory EmailID, uint MobileNo) {
        UserInfo storage ThisUser = UserMap[UserAddress][UserIndex];
        return (ThisUser.FullName, ThisUser.EmailID, ThisUser.MobileNo);
    }

    function viewUserDL(address UserAddress, uint RequestIndex) public view returns (
  uint8 DL_No_S,
  string memory DL_No_V,
  uint8 DL_Name_S,
  string memory DL_Name_V,
  uint8 DL_DOB_S,
  string memory DL_DOB_V,
  uint8 DL_Hash_S,
  bytes memory DL_Hash_V,
  uint8 DL_Address_S,
  string memory DL_Address_V
)
{
    UserDL storage ThisUserDL = UserDLMap[UserAddress][0];
    DLRequest storage ThisDLRequest = DLRequestMap[UserAddress][RequestIndex];

    return (
        uint8(ThisDLRequest.DL_No),
        ThisUserDL.DL_No,
        uint8(ThisDLRequest.DL_Name),
        ThisUserDL.DL_Name,
        uint8(ThisDLRequest.DL_DOB),
        ThisUserDL.DL_DOB,
        0,                          // DL_Hash_S — set to 0 or real value if applicable
        bytes(ThisUserDL.DL_Address), // DL_Hash_V — placeholder since you don't seem to have a DL_Hash
        uint8(ThisDLRequest.DL_Address),
        ThisUserDL.DL_Address
    );
}

}
