class NamazModel {
  final String? id;
  final String name;
  final String status;
  final String date;

  NamazModel({
    this.id,
    required this.name,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'date': date,
    };
  }

  factory NamazModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return NamazModel(
      id: id,
      name: (map['name'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      date: (map['date'] ?? '') as String,
    );
  }
}
