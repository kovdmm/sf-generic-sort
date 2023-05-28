public class StringDirectionalSortCriterion extends FieldSortCriterion {
    public Boolean isAscending = true;

    private Integer directionMultiplier {
        get {
            return this.isAscending ? 1 : -1;
        }
    }

    public StringDirectionalSortCriterion(String fieldName) {
        super(fieldName);
    }

    public StringDirectionalSortCriterion(String fieldName, Boolean isAscending) {
        super(fieldName);
        this.isAscending = isAscending;
    }

    public StringDirectionalSortCriterion(
        String fieldName,
        Boolean isAscending,
        Boolean nullsFirst
    ) {
        super(fieldName, nullsFirst);
        this.isAscending = isAscending;
    }

    public override Integer compare(Object arg1, Object arg2) {
        if (arg1 == arg2) {
            return 0;
        } else if (arg1 == null) {
            return -1 * this.nullsFirstMultiplier;
        } else if (arg2 == null) {
            return this.nullsFirstMultiplier;
        }
        return untypedCompare(arg1, arg2) * this.directionMultiplier;
    }

    private Integer untypedCompare(Object arg1, Object arg2) {
        if (arg1 == arg2) {
            return 0;
        }
        if (arg1 instanceof String && arg2 instanceof String) {
            return ((String) arg1).compareTo((String) arg2);
        }
        if (arg1 instanceof Integer && arg2 instanceof Integer) {
            return (Integer) arg1 > (Integer) arg2 ? 1 : -1;
        }
        throw new IllegalArgumentException('IllegalArgumentException');
    }
}
