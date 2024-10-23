import Mem "./memory/v3";
import MU "../../../src/lib";

module {


    public class Mod(xmem : MU.MemShell<Mem.One.Mem>) {
        let mem = MU.access(xmem);

        public func inc() : Nat {
            mem.counter += 1;
            mem.counter;
        };
    };
}