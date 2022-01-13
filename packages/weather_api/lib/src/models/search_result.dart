class SearchResult {
  const SearchResult({required this.title, required this.woeID});

  // The name of the search result returned.
  // Will usually be a city name,
  final String title;

  // The "Where on Earth" ID for the search result.
  // This is the ID that would be passed to the
  // weather API to get further weather information.
  final int woeID;

  SearchResult.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        woeID = json['woeid'];

  Map<String, dynamic> toJson() => {'title': title, 'woeid': woeID};

  @override
  String toString() => 'Search Result($woeID, $title)';
}
