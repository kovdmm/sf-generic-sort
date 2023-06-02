/**
 * Description
 *
 * @author: Olya Baranova
 * @date: 01/06/2023
 *
 */
public with sharing class Collection {
    public static List<Object> sort(List<Object> objects, SortableCriterion criterion) {
        return sort(objects, new List<SortableCriterion> { criterion });
    }

    public static List<Object> sort(List<Object> objects, List<SortableCriterion> criteria) {
        // если пустой или 1 элемент, вернуть клон листа
        if (objects.size() < 2) return objects.clone();

        // если элементов > 1 и тип первого примитивный, вернуть отсортированный

        // objects оборачивается в items
        List<Item> items = new List<Item>();
        for (Object obj : objects) {
            items.add(new Item(obj));
        }

        // сортируется
        items.sort();

        // разворачивается из items и возвращается
        List<Object> sortedList = new List<Object>();
        for (Item item : items) {
            sortedList.add((Object) (JSON.deserialize(JSON.serialize(item), Object.class)));
        }
        return sortedList;
    }

}