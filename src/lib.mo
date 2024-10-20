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

    public func persistent<A>(_id: Text) : MemShell<A> { { var inner = null } };

    public func placeholder() : () {
        Debug.trap("This shouldn't be deployed, but replaced by the MOUP macro")
    };
}