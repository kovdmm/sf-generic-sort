global class Item implements Comparable {
    public Object sourceObject { get; set; }
    public List<SortCriterion> criteria  { get; set; }

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
        if (this.fieldValueMap.get('age') == compareToEmp.fieldValueMap.get('age')) return 0;
        if (this.fieldValueMap.get('age') > compareToEmp.fieldValueMap.get('age')) return 1;
        return -1;
    }

    public Object getValue(String fieldName) {
        return this.fieldValueMap.get(fieldName);
    }
}
