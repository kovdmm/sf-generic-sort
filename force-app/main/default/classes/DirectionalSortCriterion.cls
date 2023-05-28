public abstract class DirectionalSortCriterion extends FieldSortCriterion {
    public Boolean isAscending { get; protected set; }

    public override Integer compare2(Object arg1, Object arg2) {
        return this.compare3(arg1, arg2) * (this.isAscending ? 1 : -1);
    }

    public abstract Integer compare3(Object arg1, Object arg2);
}
