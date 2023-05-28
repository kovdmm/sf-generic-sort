public abstract class SortCriterion implements SortableCriterion {
    public Boolean nullsFirst { get; protected set; }

    protected Integer nullsFirstMultiplier {
        get {
            return this.nullsFirst ? 1 : -1;
        }
    }

    public SortCriterion(Boolean nullsFirst) {
        this.nullsFirst = nullsFirst;
    }

    public virtual Integer compare(Object arg1, Object arg2) {
        if (arg1 == null || arg2 == null) {
            return arg1 == arg2 ? 0 : arg2 == null ? 1 : -1;
        } else {
            return this.compare2(arg1, arg2);
        }
    }

    public abstract Integer compare2(Object arg1, Object arg2);
}
