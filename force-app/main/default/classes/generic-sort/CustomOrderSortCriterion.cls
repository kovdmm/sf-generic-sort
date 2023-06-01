public class CustomOrderSortCriterion extends SortCriterion {
    public String fieldName { get; set; }
    public List<Object> customOrder { get; set; }

    public CustomOrderSortCriterion(String fieldName, List<Object> customOrder, Boolean nullsFirst) {
        this.fieldName = fieldName;
        this.customOrder = customOrder;
        this.nullsFirst = nullsFirst;
    }

    public override Integer compare2(Object arg1, Object arg2) {
        Integer index1 = this.customOrder.indexOf(arg1);
        Integer index2 = this.customOrder.indexOf(arg2);
        return index1 == index2 ? 0 : index1 > index2 ? 1 : -1;
    }
}
