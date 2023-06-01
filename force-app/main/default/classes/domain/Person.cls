/**
 * Description
 *
 * @author: Olya Baranova
 * @date: 01/06/2023
 *
 */
public with sharing class Person {
    public String firstName { get; set; }
    public String lastName { get; set; }
    public Integer age { get; set; }
    public Gender gender { get; set; }

    public Person(String firstName, String lastName, Integer age, Gender gender) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.age = age;
        this.gender = gender;
    }
}