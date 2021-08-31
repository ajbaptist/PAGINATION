import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.totalPassengers,
    required this.totalPages,
    required this.data,
  });

  int totalPassengers;
  int totalPages;
  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        totalPassengers: json["totalPassengers"],
        totalPages: json["totalPages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPassengers": totalPassengers,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.airline,
    required this.v,
  });

  String id;
  String name;

  List<Airline> airline;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        airline:
            List<Airline>.from(json["airline"].map((x) => Airline.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "airline": List<dynamic>.from(airline.map((x) => x.toJson())),
        "__v": v,
      };
}

class Airline {
  Airline({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.slogan,
    required this.headQuaters,
    required this.website,
    required this.established,
  });

  int? id;
  Name? name;
  Country? country;
  String logo;
  Slogan? slogan;
  String? headQuaters;
  Website? website;
  String? established;

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        id: json["id"],
        name: nameValues.map[json["name"]],
        country: countryValues.map[json["country"]],
        logo: json["logo"],
        slogan: sloganValues.map[json["slogan"]],
        headQuaters: json["head_quaters"],
        website: websiteValues.map[json["website"]],
        established: json["established"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "country": countryValues.reverse[country],
        "logo": logo,
        "slogan": sloganValues.reverse[slogan],
        "head_quaters": headQuaters,
        "website": websiteValues.reverse[website],
        "established": established,
      };
}

enum Country { TAIWAN, HONG_KONG, DUBAI }

final countryValues = EnumValues({
  "Dubai": Country.DUBAI,
  "Hong Kong": Country.HONG_KONG,
  "Taiwan": Country.TAIWAN
});

enum Name { EVA_AIR, CATHAY_PACIFIC, EMIRATES }

final nameValues = EnumValues({
  "Cathay Pacific": Name.CATHAY_PACIFIC,
  "Emirates": Name.EMIRATES,
  "Eva Air": Name.EVA_AIR
});

enum Slogan {
  SHARING_THE_WORLD_FLYING_TOGETHER,
  MOVE_BEYOND,
  FROM_DUBAI_TO_DESTINATIONS_AROUND_THE_WORLD
}

final sloganValues = EnumValues({
  "From Dubai to destinations around the world.":
      Slogan.FROM_DUBAI_TO_DESTINATIONS_AROUND_THE_WORLD,
  "Move Beyond": Slogan.MOVE_BEYOND,
  "Sharing the World, Flying Together": Slogan.SHARING_THE_WORLD_FLYING_TOGETHER
});

enum Website { WWW_EVAAIR_COM, WWW_CATHAYPACIFIC_COM, WWW_EMIRATES_COM }

final websiteValues = EnumValues({
  "www.cathaypacific.com": Website.WWW_CATHAYPACIFIC_COM,
  "www.emirates.com/": Website.WWW_EMIRATES_COM,
  "www.evaair.com": Website.WWW_EVAAIR_COM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: unnecessary_null_comparison
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
