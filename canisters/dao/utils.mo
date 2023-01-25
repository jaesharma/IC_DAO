// base library imports
import Time "mo:base/Time";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";

// custom imports
import SHA224 "./SHA224";
import CRC32 "./CRC32";
import Types "./types";

// external package imports
import UUID "mo:uuid/UUID";

module {
    // constant declarations
    let TESTNET_MBT_CANISTER : Text = "rrkah-fqaaa-aaaaa-aaaaq-cai";
    let MAINNET_MBT_CANISTER : Text = "";

    public func uuid() : async Text {
        return UUID.toText(UUID.Generator().new())
    };

    public func currentTime() : async Int {
        return Time.now()
    };

    public func mbt_canister_id(env : Text) : Text {
        if (Text.equal(env, "MAINNET")) {
            return ""
        } else {
            return "rrkah-fqaaa-aaaaa-aaaaq-cai"
        }
    };

    public func website_canister_id(env : Text) : Text {
        if (Text.equal(env, "MAINNET")) {
            return ""
        } else {
            return "renrk-eyaaa-aaaaa-aaada-cai"
        }
    };

    public func principalToSubaccount(principal : Principal) : async Types.Subaccount {
        let idHash = SHA224.Digest();
        idHash.write(Blob.toArray(Principal.toBlob(principal)));
        let hashSum = idHash.sum();
        let crc32Bytes = await beBytes(CRC32.ofArray(hashSum));
        let buf = Buffer.Buffer<Nat8>(32);
        let blob : Types.Subaccount = Blob.fromArray(Array.append(crc32Bytes, hashSum));
        return blob
    };

    public func accountIdentifier(principal : Principal, subaccount : Types.Subaccount) : async Types.Subaccount {
        let hash = SHA224.Digest();
        hash.write([0x0A]);
        hash.write(Blob.toArray(Text.encodeUtf8("account-id")));
        hash.write(Blob.toArray(Principal.toBlob(principal)));
        hash.write(Blob.toArray(subaccount));
        let hashSum = hash.sum();
        let crc32Bytes = await beBytes(CRC32.ofArray(hashSum));
        let res : Types.Subaccount = Blob.fromArray(Array.append(crc32Bytes, hashSum));
        return res
    };

    public func beBytes(n : Nat32) : async [Nat8] {
        func byte(n : Nat32) : Nat8 {
            Nat8.fromNat(Nat32.toNat(n & 0xff))
        };
        [byte(n >> 24), byte(n >> 16), byte(n >> 8), byte(n)]
    }
}
