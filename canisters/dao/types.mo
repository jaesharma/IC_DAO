// base library imports
import List "mo:base/List";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Int "mo:base/Int";

// external library imports
import UUID "mo:uuid/UUID";

module {
    public type ProposalTypeEnum = {
        #ChangeSubnetMembership
    };

    public type ProposalTopicEnum = {
        #SubnetManagement
    };

    public type ProposalStatusEnum = {
        #Open;
        #Rejected;
        #Accepted
    };

    public type ProposalRewardStatusEnum = {
        #AcceptingVotes
    };

    public type Proposal = {
        id : UUID.UUID;
        proposalType : ProposalTypeEnum;
        topic : ProposalTopicEnum;
        status : ProposalStatusEnum;
        rewardStatus : ProposalRewardStatusEnum;
        summary : Text;
        voters : List.List<Principal>;
        createdAt : Int; // when was created
        proposer : UUID.UUID; //The ID of the neuron that submitted the proposal.
    };

    public type NeuronState = {
        #Locked;
        #Dissolving;
        #Dissolved
    };

    public type Neuron = {
        id : UUID.UUID;
        owner : Principal;
        amount : Nat;
        dissolveDelay : Int;
        neuronState : NeuronState;
        createdAt : Int;
        dissolvedAt : Int;
        // deposit_subaccount: Principal or Blob;
    };

    // create proposal

    // get all proposals

    // get proposal by id

    // create neuron

    public type Account = { owner : Principal; subaccount : ?Subaccount };
    public type Tokens = Nat;
    public type Memo = Blob;
    public type Timestamp = Nat64;
    public type Result<T, E> = { #Ok : T; #Err : E };
    public type TxIndex = Nat;
    public type Operation = {
        #Approve : Approve;
        #Transfer : Transfer;
        #Burn : Transfer;
        #Mint : Transfer
    };
    public type CommonFields = {
        memo : ?Memo;
        fee : ?Tokens;
        created_at_time : ?Timestamp
    };
    public type Approve = CommonFields and {
        from : Account;
        spender : Principal;
        amount : Int;
        expires_at : ?Nat64
    };
    public type TransferSource = {
        #Init;
        #Icrc1Transfer;
        #Icrc2TransferFrom
    };
    public type Transfer = CommonFields and {
        spender : Principal;
        source : TransferSource;
        to : Account;
        from : Account;
        amount : Tokens
    };
    public type Allowance = { allowance : Nat; expires_at : ?Nat64 };
    public type Transaction = {
        operation : Operation;
        // Effective fee for this transaction.
        fee : Tokens;
        timestamp : Timestamp
    };
    public type DeduplicationError = {
        #TooOld;
        #Duplicate : { duplicate_of : TxIndex };
        #CreatedInFuture : { ledger_time : Timestamp }
    };
    public type CommonError = {
        #InsufficientFunds : { balance : Tokens };
        #BadFee : { expected_fee : Tokens };
        #TemporarilyUnavailable;
        #GenericError : { error_code : Nat; message : Text }
    };
    public type TransferError = DeduplicationError or CommonError or {
        #BadBurn : { min_burn_amount : Tokens }
    };
    public type ApproveError = DeduplicationError or CommonError or {
        #Expired : { ledger_time : Nat64 }
    };
    public type TransferFromError = TransferError or {
        #InsufficientAllowance : { allowance : Nat }
    };

    public type Subaccount = Blob;

    public type TransferParameters = {
        from_subaccount : ?Subaccount;
        to : Account;
        amount : Tokens;
        fee : ?Tokens;
        memo : ?Memo;
        created_at_time : ?Timestamp
    }
}
