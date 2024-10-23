import MU "../../../../src/lib";

module {

    public module HashMap {

        public func new<A,B>() : MU.MemShell<Mem<A,B>> = MU.new<Mem<A,B>>({
            var db = null;
        });


        public type Mem<A,B> = {
            var db : ?(A,B)
        };

        // No need for upgrade function here, because its the first version
    };
}