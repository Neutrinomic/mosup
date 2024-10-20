import Mem "./memory/v1";
import MU "../../moup";

module {

    public type Mem = Mem.Mem;

    public class Mod(xmem : MU.MemShell<Mem.Mem>) {
        let mem = MU.access(xmem, Mem.DefaultMem);

        public func inc() : Nat {
            mem.counter += 1;
            mem.counter;
        };
    };
}