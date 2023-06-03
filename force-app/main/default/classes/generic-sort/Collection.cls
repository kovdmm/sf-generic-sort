/**
 * Description
 *
 * @author: Olya Baranova
 * @date: 01/06/2023
 *
 */
public with sharing class Collection {
    public static Object sort(List<Object> objects, SortCriterion criterion) {
        return sort(objects, new List<SortCriterion>{criterion});
    }

    public static Object sort(List<Object> objects, List<SortCriterion> criteria) {
        objects = objects.clone();
        // если пустой или 1 элемент, вернуть клон листа
        if (objects.size() < 2) {
            return objects;
        }

        // если элементов > 1 и тип первого примитивный, вернуть отсортированный

        // objects оборачивается в items
        List<Item> items = new List<Item>();
        for (Object obj : objects) {
            items.add(new Item(obj, criteria));
        }

        // сортируется
        items.sort();

        // разворачивается из items и возвращается
        for (Integer i = 0; i < objects.size(); i++) {
            objects[i] = items[i].sourceObject;
        }
        return objects;
    }
}
