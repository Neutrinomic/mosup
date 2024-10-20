import V2 "./v2";

module {
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

    public func patch(from: V2.Mem) : Mem {
        {
            var counter = from.counter;
            var name = "John";
            var age = 33;
        }
    };
}