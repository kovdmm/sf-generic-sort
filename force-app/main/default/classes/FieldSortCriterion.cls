public abstract class FieldSortCriterion extends SortCriterion {
    public String fieldName { get; protected set; }

    public FieldSortCriterion withFieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }
}
