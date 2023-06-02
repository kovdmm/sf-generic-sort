@IsTest
private class StringDirectionalSortCriterionTest {

    @IsTest
    public static void testFirstScenario() {
        List<Person> people = new List<Person>{
                new Person('Alice', 'Zimmerman', 20, Gender.FEMALE),
                new Person('Alice', 'Brown', 20, Gender.FEMALE),
                new Person('Betty', 'Yates', 20, Gender.FEMALE),
                new Person('Bob', 'Smith', 20, Gender.MALE),
                new Person('Charlie', 'Adams', 25, Gender.MALE),
                new Person('Eve', 'Johnson', 30, Gender.FEMALE)
        };

        List<Object> sortedPeople = Collection.sort(people, new List<SortCriterion>{
                new NumericDirectionalSortCriterion('age', true, true),
                new CustomOrderSortCriterion('gender', new List<Object>{Gender.FEMALE, Gender.MALE}, true),
                new StringDirectionalSortCriterion('firstName', true, true),
                new StringDirectionalSortCriterion('lastName', false, true)
        });
    }

    @IsTest
    public static void testSecondScenario() {
        List<Person> people = new List<Person>{
                new Person('Alex', 'Black', 20, Gender.MALE),
                new Person('Alex', 'White', 20, Gender.MALE),
                new Person('Boris', 'Black', 20, Gender.MALE),
                new Person('Carl', 'Black', 20, Gender.MALE)
        };

        List<Object> sortedPeople = Collection.sort(people, new List<SortCriterion>{
                new CustomOrderSortCriterion('gender', new List<Object>{Gender.MALE, Gender.FEMALE}, true),
                new StringDirectionalSortCriterion('firstName', false, true),
                new StringDirectionalSortCriterion('lastName', true, true),
                new NumericDirectionalSortCriterion('age', true, true)
        });
    }
}
