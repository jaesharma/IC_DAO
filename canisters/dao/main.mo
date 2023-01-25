// base library imports
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

// custom imports
import Types "./types";
import Utils "./utils";

// external packages' imports
import UUID "mo:uuid/UUID";

actor class DAO() = this {

  stable let ENV : Text = "TESTNET";

  /**
        submit_proposal
        get_proposal
        get_all_proposals
        vote
        modify_parameters
        quadratic_voting
        createNeuron
        dissolveNeuron
    */

  public type ProposalTypeEnum = Types.ProposalTypeEnum;
  public type ProposalTopicEnum = Types.ProposalTopicEnum;
  public type ProposalStatusEnum = Types.ProposalStatusEnum;
  public type ProposalRewardStatusEnum = Types.ProposalRewardStatusEnum;
  public type Proposal = Types.Proposal;
  public type Neuron = Types.Neuron;
  public type UUID = UUID.UUID;

  // external canister actor initialization
  let MBT : actor {
    icrc1_balance_of : (Types.Account) -> async Nat;
    icrc1_transfer : (Types.TransferParameters) -> async Types.Result<Types.TxIndex, Types.TransferError>;
  } = actor (Utils.mbt_canister_id(ENV));

  let WEBSITE : actor {
    update_site_text : (text : Text) -> async ();
  } = actor (Utils.website_canister_id(ENV));

  public shared ({ caller }) func submit_proposal(this_payload : Text) : async {
    #Ok : Proposal;
    #Err : Text;
  } {
    if (Principal.isAnonymous(caller)) {
      throw Error.reject("Unauthorized");
    };

    // get balance
    // 
    return #Err("Not implemented yet");
  };

  public shared ({ caller }) func vote(proposal_id : Int, yes_or_no : Bool) : async {
    #Ok : (Nat, Nat);
    #Err : Text;
  } {
    return #Err("Not implemented yet");
  };

  public query func get_proposal(id : Int) : async ?Proposal {
    return null;
  };

  public query func get_all_proposals() : async [(Int, Proposal)] {
    return [];
  };

  public shared ({ caller }) func create_neuron() : async Bool {
    // TODO: anonymity check

    let canisterPrincipal = await selfIdentifier();
    let callerSubAccount : Types.Subaccount = await Utils.accountIdentifier(canisterPrincipal, await Utils.principalToSubaccount(caller));
    let accountObj = {
      owner = canisterPrincipal;
      subaccount = ?callerSubAccount;
    };
    let balance = await get_account_balance(accountObj);
    Debug.print(Nat.toText(balance));

    return 1 == 1;
  };

  public func get_account_balance(id : Types.Account) : async Nat {
    let balance = await MBT.icrc1_balance_of(id);
    return balance;
  };

  public func selfIdentifier() : async Principal {
    return Principal.fromActor(this);
  };
};
