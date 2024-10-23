import MU "../../../../src/lib";
import V1 "./v1";

module {

    public module One {

        public func new() : MU.MemShell<Mem> = MU.new({
            var counter = 0;
            var name = "John"
        });
        

        public type Mem = {
            var counter : Nat;
            var name : Text;
        };

        // Module type upgrade
        public func upgrade(from: V1.One.Mem) : Mem {
            {
                var counter = from.counter;
                var name = "John";
            }
        };
    };
}