const String tableFavorite = 'favorite';

class FavoriteFields {
  static final List<String> values = [
    id,
    types,
    origin,
    originGlobalId,
    destination
  ];
  static const String id = '_id';
  static const String types = 'types';
  static const String origin = 'origin';
  static const String originGlobalId = 'originGlobalId';
  static const String destination = 'destination';
}

class Favorite {
  final int? id;
  final String types;
  final String origin;
  final String originGlobalId;
  final String destination;

  const Favorite(
      {this.id,
      required this.types,
      required this.origin,
      required this.originGlobalId,
      required this.destination});

  static Favorite fromJson(Map<String, Object?> json) => Favorite(
        id: json[FavoriteFields.id] as int?,
        types: json[FavoriteFields.types] as String,
        origin: json[FavoriteFields.origin] as String,
        originGlobalId: json[FavoriteFields.originGlobalId] as String,
        destination: json[FavoriteFields.destination] as String,
      );

  Map<String, Object?> toJson() => {
        FavoriteFields.id: id,
        FavoriteFields.types: types,
        FavoriteFields.origin: origin,
        FavoriteFields.originGlobalId: originGlobalId,
        FavoriteFields.destination: destination
      };

  Favorite copy(
          {int? id,
          String? types,
          String? origin,
          String? originGlobalId,
          String? destinations}) =>
      Favorite(
          id: id ?? this.id,
          types: types ?? this.types,
          origin: origin ?? this.origin,
          originGlobalId: originGlobalId ?? this.originGlobalId,
          destination: destinations ?? this.destination);
}
