public class CustomOrderSortCriterion extends FieldSortCriterion {
    public List<Object> customOrder { get; private set; }

    public CustomOrderSortCriterion withCustomOrder(List<Object> customOrder) {
        this.customOrder = customOrder;
        return this;
    }

    public override Integer compare2(Object arg1, Object arg2) {
        Integer index1 = this.customOrder.indexOf(arg1);
        Integer index2 = this.customOrder.indexOf(arg2);
        return index1 == index2 ? 0 : index1 > index2 ? 1 : -1;
    }
}
