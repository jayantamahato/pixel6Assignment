class PostalResModel {
  String? status;
  int? statusCode;
  int? postcode;
  List<City>? city;
  List<State>? state;

  PostalResModel(
      {this.status, this.statusCode, this.postcode, this.city, this.state});

  PostalResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    postcode = json['postcode'];
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(City.fromJson(v));
      });
    }
    if (json['state'] != null) {
      state = <State>[];
      json['state'].forEach((v) {
        state!.add(State.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['postcode'] = postcode;
    if (city != null) {
      data['city'] = city!.map((v) => v.toJson()).toList();
    }
    if (state != null) {
      data['state'] = state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class State {
  int? id;
  String? name;

  State({this.id, this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
