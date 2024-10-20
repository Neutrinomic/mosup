import V1 "./v1";

module {
    public func DefaultMem() : Mem {
        {
            var counter = 0;
            var name = "John";
        }
    };

    public type Mem = {
        var counter : Nat;
        var name : Text;
    };

    public func patch(from: V1.Mem) : Mem {
        {
            var counter = from.counter;
            var name = "John";
        }
    };
}