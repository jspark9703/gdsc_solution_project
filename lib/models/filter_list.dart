// Filter 모델
class Filter {
  String title;
  String num;
  String url;

  Filter({
    required this.title,
    required this.num,
    required this.url,
  });

  // JSON에서 Filter 객체로 변환하는 팩토리 생성자
  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        title: json['title'],
        num: json['num'],
        url: json['url'],
      );

  // Filter 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'title': title,
        'num': num,
        'url': url,
      };
}

// FilterList 모델
class FilterList {
  List<Filter> filterList;

  FilterList({required this.filterList});

  // JSON에서 FilterList 객체로 변환하는 팩토리 생성자
  factory FilterList.fromJson(Map<String, dynamic> json) => FilterList(
        filterList: List<Filter>.from(json['filter_list'].map((x) => Filter.fromJson(x))),
      );

  // FilterList 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'filter_list': List<dynamic>.from(filterList.map((x) => x.toJson())),
      };
}
