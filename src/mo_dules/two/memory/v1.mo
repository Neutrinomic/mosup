
module {
    public func DefaultMem() : Mem {
        {
            var counter = 0;
        }
    };

    public type Mem = {
        var counter : Nat;
    };
}