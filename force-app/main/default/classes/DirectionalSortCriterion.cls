public abstract class DirectionalSortCriterion extends FieldSortCriterion {
    public String fieldName { get; protected set; }
    public Boolean isAscending { get; protected set; }
    public Boolean nullsFirst { get; protected set; }

    public DirectionalSortCriterion(String fieldName, Boolean isAscending, Boolean nullsFirst) {
        this.fieldName = fieldName;
        this.isAscending = isAscending;
        this.nullsFirst = nullsFirst;
    }

    public override Integer compare2(Object arg1, Object arg2) {
        return this.compare3(arg1, arg2) * (this.isAscending ? 1 : -1);
    }

    public abstract Integer compare3(Object arg1, Object arg2);
}
