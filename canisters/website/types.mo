import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Nat16 "mo:base/Nat16";

module {
    public type Key = Blob;
    public type Hash = Blob;
    public type Value = Blob;

    public type HashTree = {
        #empty;
        #pruned : Hash;
        #fork : (HashTree, HashTree);
        #labeled : (Key, HashTree);
        #leaf : Value
    };

    public type HeaderField = (Text, Text);

    public type HttpResponse = {
        status_code : Nat16;
        headers : [HeaderField];
        body : Blob
    };

    public type HttpRequest = {
        method : Text;
        url : Text;
        headers : [HeaderField];
        body : Blob
    };
}
