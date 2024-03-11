// To parse this JSON data, do
//
//     final ipixrestaurant = ipixrestaurantFromJson(jsonString);

import 'dart:convert';

Ipixrestaurant ipixrestaurantFromJson(String str) => Ipixrestaurant.fromJson(json.decode(str));

String ipixrestaurantToJson(Ipixrestaurant data) => json.encode(data.toJson());

class Ipixrestaurant {
    List<Restaurant>? restaurants;

    Ipixrestaurant({
        this.restaurants,
    });

    factory Ipixrestaurant.fromJson(Map<String, dynamic> json) => Ipixrestaurant(
        restaurants: json["restaurants"] == null ? [] : List<Restaurant>.from(json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
    };
}

class Restaurant {
    int? id;
    String? name;
    Neighborhood? neighborhood;
    String? photograph;
    String? address;
    Latlng? latlng;
    String? cuisineType;
    OperatingHours? operatingHours;
    List<Review>? reviews;

    Restaurant({
        this.id,
        this.name,
        this.neighborhood,
        this.photograph,
        this.address,
        this.latlng,
        this.cuisineType,
        this.operatingHours,
        this.reviews,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        neighborhood: neighborhoodValues.map[json["neighborhood"]]!,
        photograph: json["photograph"],
        address: json["address"],
        latlng: json["latlng"] == null ? null : Latlng.fromJson(json["latlng"]),
        cuisineType: json["cuisine_type"],
        operatingHours: json["operating_hours"] == null ? null : OperatingHours.fromJson(json["operating_hours"]),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "neighborhood": neighborhoodValues.reverse[neighborhood],
        "photograph": photograph,
        "address": address,
        "latlng": latlng?.toJson(),
        "cuisine_type": cuisineType,
        "operating_hours": operatingHours?.toJson(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    };
}

class Latlng {
    double? lat;
    double? lng;

    Latlng({
        this.lat,
        this.lng,
    });

    factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

enum Neighborhood {
    BROOKLYN,
    MANHATTAN,
    QUEENS
}

final neighborhoodValues = EnumValues({
    "Brooklyn": Neighborhood.BROOKLYN,
    "Manhattan": Neighborhood.MANHATTAN,
    "Queens": Neighborhood.QUEENS
});

class OperatingHours {
    String? monday;
    String? tuesday;
    String? wednesday;
    String? thursday;
    String? friday;
    String? saturday;
    String? sunday;

    OperatingHours({
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday,
    });

    factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
        monday: json["Monday"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thursday: json["Thursday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
        sunday: json["Sunday"],
    );

    Map<String, dynamic> toJson() => {
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
    };
}

class Review {
    String? name;
    Date? date;
    int? rating;
    String? comments;

    Review({
        this.name,
        this.date,
        this.rating,
        this.comments,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        date: dateValues.map[json["date"]]!,
        rating: json["rating"],
        comments: json["comments"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date": dateValues.reverse[date],
        "rating": rating,
        "comments": comments,
    };
}

enum Date {
    OCTOBER_262016
}

final dateValues = EnumValues({
    "October 26, 2016": Date.OCTOBER_262016
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
