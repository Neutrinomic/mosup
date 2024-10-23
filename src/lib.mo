import Debug "mo:base/Debug";
import Option "mo:base/Option";


module {

    public type MemShell<M> = {
        var inner : ?M;
    };

    public func new<Mem>(m:Mem) : MemShell<Mem> {
        { var inner = ?m }
    };

    public func upgrade<From, To>(from:MemShell<From>, fn:From -> To) : MemShell<To> {
        let ?f = from.inner else Debug.trap("Upgrading from non existing memory");
        let r = { var inner = ?fn(f) };
        clear(from);
        r;
    };

    public func access<A>(xmem : MemShell<A>) : A {
        let ?mem = xmem.inner else Debug.trap("Accessing uninitialized memory");
        mem;
    };

    public func clear<A>(xmem : MemShell<A>) {
        xmem.inner := null;
    };

}