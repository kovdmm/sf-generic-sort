public class ComparableDirectionalSortCriterion extends DirectionalSortCriterion {
    public override Integer compare3(Object arg1, Object arg2) {
        return ((Comparable) arg1).compareTo(arg2);
    }
}
