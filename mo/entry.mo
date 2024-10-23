
import MU_mymod_mem2 "./mo_dules/mymod/memory/v2";
import MU_mymod_mem3 "./mo_dules/mymod/memory/v3";

import MU_hashmap_mem1 "./mo_dules/hashmap/memory/v1";

import Mymod "./mo_dules/mymod";
import HashMap "./mo_dules/hashmap";


import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

actor {

    // stable memory 'abc'

    stable let mem_abc_2 = MU_mymod_mem2.One.new();

    stable let mem_abc_3 = MU_mymod_mem3.One.upgrade(mem_abc_2);
    
    let mod_one = Mymod.Mod(mem_abc_3);

    // stable memory 'two'

    stable let mem_two_1 = MU_hashmap_mem1.HashMap.new<Text,Nat>();

    stable let mem_two_2 = MU_hashmap_mem1.HashMap.new<Blob,Nat8>();

    HashMap.upgrade(mem_two_1, mem_two_2,
        func(x :?(Text,Nat)) : ?(Blob,Nat8) { // Custom function provided by the library
            let ?a = x else return null;
            ?(Text.encodeUtf8(a.0), Nat8.fromNat(a.1))
        }
    );


    let mymap = HashMap.HashMap(mem_two_2);
    
    // public func

    public func inc() : async Nat = async mod_one.inc();


}


