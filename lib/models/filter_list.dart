import 'dart:convert';

class FilterList {
  List<Filter> filterList;

  FilterList({
    required this.filterList,
  });

  factory FilterList.fromJson(String jsonString) {
    List<dynamic> filterListJson = json.decode(jsonString)['filterList'];
    List<Filter> filters = filterListJson.map((filterJson) {
      return Filter.fromJson(filterJson);
    }).toList();

    return FilterList(filterList: filters);
  }

  String toJson() {
    List<Map<String, dynamic>> filterListJson =
        filterList.map((filter) => filter.toJson()).toList();

    return json.encode({'filterList': filterListJson});
  }
}

class Filter {
  String filterTitle;
  List<String> filterContent;

  Filter({
    required this.filterTitle,
    required this.filterContent,
  });

  factory Filter.fromJson(Map<String, dynamic> json) {
    List<dynamic> filterContentJson = json['filterContent'];
    List<String> filterContent =
        filterContentJson.map((content) => content.toString()).toList();

    return Filter(
      filterTitle: json['filterTitle'].toString(),
      filterContent: filterContent,
    );
  }

  Map<String, dynamic> toJson() {
    List<String> filterContentJson =
        filterContent.map((content) => content).toList();

    return {
      'filterTitle': filterTitle,
      'filterContent': filterContentJson,
    };
  }
}
