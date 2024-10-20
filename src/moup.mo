import Debug "mo:base/Debug";
import Option "mo:base/Option";

module {

    public type MemShell<M> = {
        var inner : ?M;
    };

    public func access<A>(xmem : MemShell<A>, default: () -> A) : A {
        if (Option.isNull(xmem.inner)) xmem.inner := ?default();
        let ?mem = xmem.inner else Debug.trap("Unreachable");
        mem;
    };
}