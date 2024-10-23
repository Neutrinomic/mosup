import MU "../../../../src/lib";
import V2 "./v2";
import Debug "mo:base/Debug";

module {

    public module One {

        public func new() : MU.MemShell<Mem> = MU.new({
            var counter = 0;
            var name = "John";
            var age = 888;
        });
        
        public func DefaultMem() : Mem {
            {
                var counter = 0;
                var name = "John";
                var age = 0;
            }
        };

        public type Mem = {
            var counter : Nat;
            var name : Text;
        };

        // Module type upgrade
        public func upgrade(from: MU.MemShell<V2.One.Mem>) : MU.MemShell<Mem> {
            MU.upgrade(from, func (a : V2.One.Mem) : Mem {
                {
                    var counter = a.counter;
                    var name = a.name;
                    var age = 888;
                }
            });
        };
    };
}