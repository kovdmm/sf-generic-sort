public class Item implements Comparable {
    Object sourceObject;
    List<SortCriterion> criteria;
    Map<String, Object> fieldValueMap {
        get {
            if (this.fieldValueMap == null) {
                this.fieldValueMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(sourceObject, false));
            }
            return this.fieldValueMap;
        }
    }

    Integer compareTo(Object compareTo) {
        Item compareToEmp = (Item) compareTo;
        // Циклом по всем полям
        if (getValue('age') == compareToEmp.getValue('age')) return 0;
        if (getValue('age') > compareToEmp.getValue('age')) return 1;
        return -1;
    }

    public Object getValue(String fieldName) {
        return this.fieldValueMap.get(fieldName);
    }
}
