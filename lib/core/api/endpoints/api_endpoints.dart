class ApiEndpoints {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1/";
  static const String searchByName = "search.php?s=";
  static const String searchByfirstLetter = "search.php?f=";
  static const String category = "categories.php";
  // filter by area, category and integration
  static const String filterByIntegration = "filter.php?i=";
  static const String filterByCategory = "filter.php?c=";
  static const String filterByArea = "filter.php?a=";
  // list of area, category and integration
  static const String listOFArea = "list.php?a=list";
  static const String listOfCategory = "list.php?c=list";
  static const String listOfIntegration = "list.php?i=list";
  // detial of meal
  static const String detailView = "lookup.php?i=";
}