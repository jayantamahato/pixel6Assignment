class PostalModel {
  int? postcode;

  PostalModel({this.postcode});

  PostalModel.fromJson(Map<String, dynamic> json) {
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postcode'] = postcode;
    return data;
  }
}
