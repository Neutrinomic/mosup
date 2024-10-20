import MU_one "./mo_dules/one";
import MU_two "./mo_dules/two";

import MU "../src/lib";

actor {

    MU.placeholder();

    let mod_one = MU_one.Mod(MU.persistent("one"));

    let mod_two = MU_two.Mod(MU.persistent("two"));


    public func inc() : async Nat = async mod_one.inc();
}


