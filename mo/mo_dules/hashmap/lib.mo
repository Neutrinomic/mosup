import Memory "./memory/v1";
import MU "../../../src/lib";

module {

    public type Mem<K,V> = Memory.HashMap.Mem<K,V>;

    // This kind of upgrade is required when we are upgrading the custom types, not the module types
    public func upgrade<A,B,C,D>(from: MU.MemShell<Mem<A,B>>, to: MU.MemShell<Mem<C,D>>, upgradeItem: (?(A,B)) -> (?(C,D))) : () {
        let mod_before = HashMap(from);
        let mod_after = HashMap(to);
        mod_after.set( upgradeItem ( mod_before.get() ) ); // In a real HashMap we will be iterating over all the items here
        MU.clear(from);
    };

    // Not a real HashMap, but pattern should be the same
    public class HashMap<K,V>(xmem : MU.MemShell<Mem<K,V>>) {
        let mem = MU.access(xmem);

        public func get() : ?(K,V) {
            mem.db;
        };

        public func set( item : ?(K, V)) {
            mem.db := item;
        }
        
    };
}