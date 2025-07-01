import 'package:workforce/Core/app_core.dart';

class ActivityModel {
  final String id;
  final String title;
  final String description;
  final String performedBy;
  final DateTime timestamp;

  ActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.performedBy,
    required this.timestamp,
  });

  factory ActivityModel.fromMap(Map<String, dynamic> map, String id) {
    return ActivityModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      performedBy: map['performedBy'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
