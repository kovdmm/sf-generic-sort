public virtual class StringDirectionalSortCriterion extends DirectionalSortCriterion {
    public override Integer compare3(Object arg1, Object arg2) {
        return String.valueOf(arg1).compareTo(String.valueOf(arg2));
    }
}
