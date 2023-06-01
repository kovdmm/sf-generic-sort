public class Item implements Comparable {
    Map<String,Object> fieldValueMap { get; set; }

    public Item(Map<String,Object> fieldValueMap) {
        this.fieldValueMap = fieldValueMap;
    }
    public Integer compareTo(Object compareTo) {
        return 0; // TODO: implement
    }
}
