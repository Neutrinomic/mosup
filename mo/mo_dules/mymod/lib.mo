import Ver1 "./memory/v1";
import Ver2 "./memory/v2";
import MU "../../../src/lib";

module {

    // exposing memory versions here is part of the standard
    public module Mem {
        public module One {
            public let V1 = Ver1.One;
            public let V2 = Ver2.One;
        };
    };


    // the following is not part of the standard
    let M = Mem.One.V2;

    public class Mod(xmem : MU.MemShell<M.Mem>) {
        let mem = MU.access(xmem);

        public func inc() : Nat {
            mem.counter += 1;
            mem.counter;
        };
    };
}