// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    String id;
    String name;
    String description;
    int price;
    String category;
    String categoryDisplay;
    String thumbnail;
    int likes;
    bool isFeatured;
    int userId;
    String userUsername;

    Welcome({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.category,
        required this.categoryDisplay,
        required this.thumbnail,
        required this.likes,
        required this.isFeatured,
        required this.userId,
        required this.userUsername,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        categoryDisplay: json["category_display"],
        thumbnail: json["thumbnail"],
        likes: json["likes"],
        isFeatured: json["is_featured"],
        userId: json["user_id"],
        userUsername: json["user_username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "category_display": categoryDisplay,
        "thumbnail": thumbnail,
        "likes": likes,
        "is_featured": isFeatured,
        "user_id": userId,
        "user_username": userUsername,
    };
}
