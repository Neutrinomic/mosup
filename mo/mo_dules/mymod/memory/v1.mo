import MU "../../../../src/lib";

module {

    public module One {

        public func new() : MU.MemShell<Mem> = MU.new({
            var counter = 0;
        });
        

        public type Mem = {
            var counter : Nat;
        };

        // No need for upgrade function here, because its the first version
    };
}