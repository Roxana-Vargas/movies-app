import 'dart:convert';

Credits creditsFromJson(String str) => Credits.fromJson(json.decode(str));

class Credits {
  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  final int id;
  final List<Cast> cast;
  final List<Cast> crew;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    // required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    // this.department,
    this.job,
  });

  final bool adult;
  final int gender;
  final int id;
  // final Department knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;
  // final Department? department;
  final String? job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        // knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        // department: departmentValues.map[json["department"]]!,
        job: json["job"],
      );

  get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    return 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg';
  }
}

// enum Department {
//   acting,
//   production,
//   editing,
//   writing,
//   sound,
//   directive,
//   camera,
//   costumeMakeUp,
//   art,
//   crew,
//   visualEffects,
//   lighting
// }

// final departmentValues = EnumValues({
//   "Acting": Department.acting,
//   "Art": Department.art,
//   "Camera": Department.camera,
//   "Costume & Make-Up": Department.costumeMakeUp,
//   "Crew": Department.crew,
//   "Directing": Department.directive,
//   "Editing": Department.editing,
//   "Lighting": Department.lighting,
//   "Production": Department.production,
//   "Sound": Department.sound,
//   "Visual Effects": Department.visualEffects,
//   "Writing": Department.writing
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
