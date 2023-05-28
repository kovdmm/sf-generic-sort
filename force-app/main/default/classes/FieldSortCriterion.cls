public abstract class FieldSortCriterion extends SortCriterion {
    public String fieldName { get; protected set; }

    public FieldSortCriterion(String fieldName) {
        this(fieldName, true);
    }

    public FieldSortCriterion(String fieldName, Boolean nullsFirst) {
        super(nullsFirst);
        this.fieldName = fieldName;
    }
}
