interface SortableCriterion {
    Integer compare(Object arg1, Object arg2);
}

public abstract class SortCriterion implements SortableCriterion {
    public Boolean nullsFirst { get; protected set; } // true
    public Boolean nullsFirstMultiplier { get {...} } // true

    public SortCriterion(Boolean nullsFirst) {}

    public virtual Integer compare(Object arg1, Object arg2) {
        if (arg1 == null || arg2 == null) {
            return arg1 == arg2 ? 0 : arg2 == null ? 1 : -1;
        } else {
            return this.compare2(arg1, arg2);
        }
    }

    public abstract Integer compare2(Object arg1, Object arg2);
}

public abstract class FieldSortCriterion extends SortCriterion {
    public String fieldName { get; protected set; }

    public FieldSortCriterion(String fieldName) {}
    public FieldSortCriterion(String fieldName, Boolean nullsFirst) {}
}

public abstract class DirectionalSortCriterion extends FieldSortCriterion {
    public Boolean isAscending { get; protected set; } // true
    public Integer directionMultiplier { get { ... } }

    public virtual Integer compare2(Object arg1, Object arg2) {
        return this.compare3(arg1, arg2) * this.directionMultiplier;
    }

    public abstract Integer compare3(Object arg1, Object arg2);
}

public virtual class StringDirectionalSortCriterion extends DirectionalSortCriterion {
    public override Integer compare3(Object arg1, Object arg2) {
        return String.valueOf(arg1).compareTo(String.valueOf(arg2)); // [-1, 0, 1]
    }
}

public class DateTimeDirectionalSortCriterion extends StringDirectionalSortCriterion {
}

public class DateDirectionalSortCriterion extends StringDirectionalSortCriterion {
}

public class TimeDirectionalSortCriterion extends StringDirectionalSortCriterion {
}

public class NumericDirectionalSortCriterion extends DirectionalSortCriterion {
    public override Integer compare3(Object arg1, Object arg2) {
        return (arg1 == arg2 ? 0 : (Double) arg1 > (Double) arg2 ? 1 : -1); // [-1, 0, 1]
    }
}

public class ComparableDirectionalSortCriterion extends DirectionalSortCriterion {
    public override Integer compare3(Object arg1, Object arg2) {
        return ((Comparable) arg1).compareTo(arg2); // [-1, 0, 1]
    }
}

public class CustomOrderSortCriterion extends FieldSortCriterion {
    List<Object> customOrder { get; private set; }

    public Integer compare2(Object arg1, Object arg2) {
        Integer index1 = this.customOrder.indexOf(arg1);
        Integer index2 = this.customOrder.indexOf(arg2);
        return index1 == index2 ? 0 : index1 > index2 ? 1 : -1;
    }
}





public class Collection {
    public static List<Object> sort(List<Object> objects, SortableCriterion criterion) {
        return sort(objects, new List<SortableCriterion> { criterion });
    }

    public static List<Object> sort(List<Object> objects, List<SortableCriterion> criteria) {
        // если пустой или 1 элемент, вернуть клон листа
        // если элементов > 1 и тип первого примитивный, вернуть отсортированный
        // objects оборачивается в items
        // сортируется
        // разворачивается из items и возвращается
    }
}




class Item implements Comparable {
    Object sourceObject;

    List<SortCriterion> criteria;

    // FIXME: better name
    Map<String, Object> sourceObjectMap {
        get {
            if (this.sourceObjectMap == null) {
                this.sourceObjectMap = JSON.deserializeUntyped(JSON.serialize(sourceObject, false))
            }
            return this.sourceObjectMap;
        }
    }

    Integer compareTo(Object compareTo) {
        Item compareToEmp = (Item)compareTo;
        // Циклом по всем полям
        if (this.sourceObjectMap.get('age') == compareToEmp.sourceObjectMap.get('age')) return 0;
        if (this.sourceObjectMap.get('age') > compareToEmp.sourceObjectMap.get('age')) return 1;
        return -1;
    }
}

enum Gender { MALE, FEMALE }

class Person {
    String firstName;
    String lastName;
    Integer age;
    Gender gender;
    List<Person> children;
}





List<Person> people = new List<Person> {
    new Person('Alex', 'Black', 20, Gender.MALE),
    new Person('Alex', 'White', 20, Gender.MALE),
    new Person('Boris', 'Black', 20, Gender.MALE),
    new Person('Carl', 'Black', 20, Gender.MALE),
};

people = Collection.sort(people, new List<SortCriterion> {
    new DirectionalSortCriterion('firstName', false), // false <-- DirectionalSortCriterion.SortDirection.DESCENDING
    new DirectionalSortCriterion('lastName'),
    new CustomOrderSortCriterion('gender', new List<Object> { Gender.FEMALE, Gender.MALE }),
    new AggregationSortCriterion('children', true, AggregationSortCriterion.COUNT),
    //new AggregationSortCriterion('children', true, new AverageChildAge()), // Aggregation Predicate
});



SortParams <- CustomOrderSortParams
    ^
    |
DirectionalSortParams




people = Collection.sort(people, new List<SortCriterion> {
    //DirectionalSortCriterion.create(new List<Object> { new SortingField('firstName'), GenericSort.SortDirection.DESCENDING, GenericSort.NullPolicy.NULLS_LAST }),
    //DirectionalSortCriterion.create(new DirectionalSortParams('firstName', GenericSort.SortDirection.DESCENDING, GenericSort.NullPolicy.NULLS_LAST)),
    //DirectionalSortCriterion.create(new DirectionalSortParams('firstName', new List<Object> { GenericSort.SortDirection.DESCENDING, GenericSort.NullPolicy.NULLS_LAST })),
    DirectionalSortCriterion.create(new DirectionalSortParams('firstName', false, false)),
    DirectionalSortCriterion.create(new DirectionalSortParams('lastName')),
    CustomOrderSortCriterion.create(new CustomOrderSortParams('gender', new List<Object> { Gender.MALE, Gender.FEMALE }), false),
    //AggregationSortCriterion.create(new AggregationSortParams('children', new AverageChildAge(), true), // Aggregation Predicate
});

//SELECT Id, FirstName, LastName, Email, Phone FROM User ORDER BY FirstName DESC, LastName ASC

class Person {
    Integer age;

    public Person(Integer age) {
        this.age = age;
    }

    public Boolean equals(Object otherPerson) {
        return this.age == ((Person) otherPerson).age;
    }
}

Boolean compare(Object arg1, Object arg2) {
    return arg1.equals(arg2);
}

System.debug(compare(1, 1)); // true
System.debug(compare('123', '123')); // true
System.debug(compare(true, true)); // true
System.debug(compare(new List<String>{ '123' }, new List<Object>{ '123' })); // true
System.debug(compare(new List<String>{ '111' }, new List<Object>{ '222' })); // false
System.debug(compare(new Person(10), new Person(10))); // false
System.debug(compare('123', 123)); // false
System.debug(compare(null, false)); // false

System.debug('123'.compareTo('123')); // 0
System.debug('123'.compareTo('124')); // -1
System.debug('123'.compareTo('122')); // 1

class Item implements Comparable {
    String value;

    public Item(String value) {
        this.value = value;
    }

    public Integer compareTo(Object compareTo) {
        Item otherItem = (Item) compareTo;
        System.debug(this.value + ' > ' + otherItem.value + ' ? 1 : -1' + ' => ' + this.value.compareTo(otherItem.value));
        return this.value.compareTo(otherItem.value);
        //return this.value == otherItem.value ? 0 : this.value > otherItem.value ? 1 : -1;
    }
}

List<Item> strings = new List<Item> { new Item('123'), new Item('122'), new Item('124') }; // TODO: check nulls also
strings.sort();
System.debug(strings);

[1, 2, 3].sort((a, b) => a > b ? 1 : - 1) // [1, 2, 3]

List<String> strings = new List<String> { null, '123', '122', '124', null };
strings.sort();
System.debug(strings);

Object ob1 = '123';
Object ob2 = '123';
Object ob3 = 123;
System.debug(((String)ob1).compareTo((String) ob2));
//System.debug(ob1 > ob2); // Inequality operator not allowed for this type: Object
System.debug(ob1 instanceof String); // true
System.debug(ob1 instanceof Integer); // false
System.debug(ob3 instanceof Integer); // true
System.debug(ob3 instanceof String); // false


System.assertEquals(0, 'Alex'.compareTo('Alex'));
System.assertEquals(-1, 'Alex'.compareTo('Boris'));
System.assertEquals(1, 'Boris'.compareTo('Alex'));

Type t = Comparable.class;
System.debug(Item.class.isAssignableFrom(t));

DateTime dt = DateTime.now();
System.debug(dt);
System.debug(String.valueOf(dt));
