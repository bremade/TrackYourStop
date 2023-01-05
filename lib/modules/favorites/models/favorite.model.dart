const String tableFavorite = 'favorite';

class FavoriteFields {
  static final List<String> values = [
    id,
    types,
    origin,
    originGlobalId,
    destinations
  ];
  static const String id = '_id';
  static const String types = 'types';
  static const String origin = 'origin';
  static const String originGlobalId = 'originGlobalId';
  static const String destinations = 'destinations';
}

class Favorite {
  final int? id;
  final String types;
  final String origin;
  final String originGlobalId;
  final String destinations;

  const Favorite(
      {this.id,
      required this.types,
      required this.origin,
      required this.originGlobalId,
      required this.destinations});

  static Favorite fromJson(Map<String, Object?> json) => Favorite(
        id: json[FavoriteFields.id] as int?,
        types: json[FavoriteFields.types] as String,
        origin: json[FavoriteFields.origin] as String,
        originGlobalId: json[FavoriteFields.originGlobalId] as String,
        destinations: json[FavoriteFields.destinations] as String,
      );

  Map<String, Object?> toJson() => {
        FavoriteFields.id: id,
        FavoriteFields.types: types,
        FavoriteFields.origin: origin,
        FavoriteFields.originGlobalId: originGlobalId,
        FavoriteFields.destinations: destinations
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
          destinations: destinations ?? this.destinations);
}
