abstract class DirectionalSortCriterion extends FieldSortCriterion {
    public Boolean isAscending { get; protected set; }
    public Integer directionMultiplier {
        get {
            return this.isAscending ? 1 : -1;
        }
    }

    public FieldSortCriterion(String fieldName) {
        this(fieldName, true);
    }

    public FieldSortCriterion(String fieldName, Boolean isAscending) {
        super(fieldName);
        this.isAscending = isAscending;
    }

    public FieldSortCriterion(String fieldName, Boolean isAscending, Boolean nullsFirst) {
        super(fieldName, nullsFirst);
        this.isAscending = isAscending;
    }

    public virtual Integer compare2(Object arg1, Object arg2) {
        return this.compare3(arg1, arg2) * this.directionMultiplier;
    }

    public abstract Integer compare3(Object arg1, Object arg2);
}
