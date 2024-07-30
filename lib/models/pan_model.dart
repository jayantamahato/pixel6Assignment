class PanModel {
  String? panNumber;

  PanModel({this.panNumber});

  PanModel.fromJson(Map<String, dynamic> json) {
    panNumber = json['panNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['panNumber'] = panNumber;
    return data;
  }
}
