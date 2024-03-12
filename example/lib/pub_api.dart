class PublicApi {
  String API;
  String? Description;
  String Auth;
  bool Https;
  String? Cors;
  String? Category;
  String? Link;

  PublicApi({
    required this.API,
    this.Description,
    required this.Auth,
    required this.Https,
    this.Cors,
    this.Category,
    this.Link,
  });

  factory PublicApi.fromJson(Map<String, dynamic> json) {
    return PublicApi(
      API: json['title'],
      Description: json['description'],
      Auth: json['auth'],
      Https: json['https'],
      Cors: json['cors'],
      Category: json['category'],
      Link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': API,
      'description': Description,
      'auth': Auth,
      'https': Https,
      'cors': Cors,
      'category': Category,
      'link': Link,
    };
  }

  @override
  String toString() {
    return 'PublicApi{title: $API, description: $Description, auth: $Auth, https: $Https, cors: $Cors, category: $Category, link: $Link}';
  }
}
