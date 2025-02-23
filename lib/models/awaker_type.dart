class AwakerType {
  final int id;
  final String description;

  AwakerType({required this.id, required this.description});

  factory AwakerType.fromMap(Map<String, Object?> map) => AwakerType(
        id: map['id'] as int,
        description: map['description'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
      };
}
