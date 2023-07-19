import 'dart:convert';

class User {
    final int id;
    final int isVerified;

    User({
        required this.id,
        required this.isVerified,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "isVerified": isVerified,
    };
}
