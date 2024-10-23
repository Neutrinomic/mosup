import Ver1 "./memory/v1";
import MU "../../../src/lib";

module {

    // exposing memory versions here is part of the standard
    public module Mem {
        public module HashMap {
            public let V1 = Ver1.HashMap;
        };
    };



    public type M<K,V> = Ver1.HashMap.Mem<K,V>;

    // This kind of upgrade is required when we are upgrading the custom types, not the module types
    // This function is part of the standard, it has to accept two memory shells and upgrade the first one to the second one
    // Then delete the first one
    // The 'upgrade' function name types and upgradeItem function are custom

    public func upgrade<A,B,C,D>(from: MU.MemShell<M<A,B>>, to: MU.MemShell<M<C,D>>, upgradeItem: ((A,B)) -> (C,D)) : () {
        if (MU.has_upgraded(from, to)) return; //required
        
        let mod_before = HashMap(from);
        let mod_after = HashMap(to);

        
        ignore do ? { mod_after.set( upgradeItem ( mod_before.get()! ) ) }; // In a real HashMap we will be iterating over all the items here

        MU.clear(from); //required
    };

    // Not a real HashMap, but pattern should be the same
    public class HashMap<K,V>(xmem : MU.MemShell<M<K,V>>) {
        let mem = MU.access(xmem);

        public func get() : ?(K,V) {
            mem.db;
        };

        public func set( item : (K, V)) {
            mem.db := ?item;
        }
        
    };
}