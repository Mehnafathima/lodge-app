class Room {
  final String id;
  final String name;
  final bool status;

  Room({
    required this.id,
    required this.name,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      status: json['status'] ?? false, // Default to false if status is not x
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }
}
