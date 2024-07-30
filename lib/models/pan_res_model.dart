class PanResponseModel {
  String? status;
  int? statusCode;
  bool? isValid;
  String? fullName;

  PanResponseModel({this.status, this.statusCode, this.isValid, this.fullName});

  PanResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    isValid = json['isValid'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['isValid'] = this.isValid;
    data['fullName'] = this.fullName;
    return data;
  }
}
