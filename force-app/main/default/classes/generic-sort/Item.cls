global class Item implements Comparable {
    public Object sourceObject { get; set; }
    public List<SortCriterion> criteria { get; set; }

    public Map<String, Object> fieldValueMap {
        get {
            if (this.fieldValueMap == null) {
                this.fieldValueMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(sourceObject, false));
            }
            return this.fieldValueMap;
        }
        set;
    }

    public Item(Object sourceObject) {
        this.sourceObject = sourceObject;
    }

    global Integer compareTo(Object compareTo) {
        Item compareToEmp = (Item) compareTo;
        // Циклом по всем полям
        for (SortCriterion sc : criteria) {
            if (this.fieldValueMap.get(sc.fieldName) > compareToEmp.fieldValueMap.get(sc.fieldName)) return 1;
            if (this.fieldValueMap.get(sc.fieldName) < compareToEmp.fieldValueMap.get(sc.fieldName)) return -1;
            if (this.fieldValueMap.get(sc.fieldName) == compareToEmp.fieldValueMap.get(sc.fieldName)) {
                continue;
            }
            return 0;
        }
    }

    public Object getValue(String fieldName) {
        return this.fieldValueMap.get(fieldName);
    }
}
