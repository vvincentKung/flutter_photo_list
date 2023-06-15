class PhotoPayload {
  final String createdAt;
  final String url;
  final String description;
  final String location;
  final String createdBy;
  final String takenAt;
  final String id;

  const PhotoPayload({
    required this.createdAt,
    required this.url,
    required this.description,
    required this.location,
    required this.createdBy,
    required this.takenAt,
    required this.id,
  });

  factory PhotoPayload.fromJson(Map<String, dynamic> json) {
    return PhotoPayload(
      createdAt: json['createdAt'],
      url: json['url'],
      description: json['description'],
      location: json['location'],
      createdBy: json['createdBy'],
      takenAt: json['takenAt'],
      id: json['id'],
    );
  }
}
