class HomeData {
  final String title;
  final String image;

  HomeData({this.title, this.image});

  Map<String, dynamic> toMap() {
    return {'title': title, 'image': image};
  }
}
