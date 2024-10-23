

import Mymod "./mo_dules/mymod";
import HashMap "./mo_dules/hashmap";

import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

actor {

    // stable memory 'abc'

    stable let mem_abc_2 = Mymod.Mem.One.V1.new();

    stable let mem_abc_3 = Mymod.Mem.One.V2.upgrade(mem_abc_2);
    
    let mod_one = Mymod.Mod(mem_abc_3);

    // stable memory 'two'

    stable let mem_two_1 = HashMap.Mem.HashMap.V1.new<Text,Nat>();

    stable let mem_two_2 = HashMap.Mem.HashMap.V1.new<Blob,Nat8>();

    // Custom function provided by the library iterating over all items
    HashMap.upgrade(mem_two_1, mem_two_2,
        func(x :(Text,Nat)) : (Blob,Nat8) { // What happens to each item
            (Text.encodeUtf8(x.0), Nat8.fromNat(x.1))
        }
    );


    let mymap = HashMap.HashMap(mem_two_2);
    
    // public func

    public func inc() : async Nat = async mod_one.inc();


}


