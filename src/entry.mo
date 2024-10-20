import One "./mo_dules/one";
import OneMem1 "./mo_dules/one/memory/v1";
import OneMem2 "./mo_dules/one/memory/v2";
import MU "./moup";

actor {


    
    stable let mem_one_1 : MU.MemShell<OneMem1.Mem> = { var inner = null };

    stable let mem_one_2 : MU.MemShell<OneMem2.Mem> = { var inner = do ? { OneMem2.patch(mem_one_1.inner!) } };
    
    mem_one_1.inner := null;

    let mod_one = One.Mod(mem_one_2);


    public func inc() : async Nat = async mod_one.inc();
}