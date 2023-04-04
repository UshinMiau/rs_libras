import 'package:rs_libras/model/elements_categories.dart';

class Categories {
  final int id;
  final String name;
  final List<ElementsCategories> elements;

  Categories({
    required this.id,
    required this.name,
    required this.elements,
  });
}
