class Realm {
  final int id;
  final String description;
  final String icon;

  Realm({required this.id, required this.description, required this.icon});

  factory Realm.fromMap(Map<String, Object?> map) => Realm(
        id: map['id'] as int,
        description: map['description'] as String,
        icon: map['icon'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
        'icon': icon,
      };
}
