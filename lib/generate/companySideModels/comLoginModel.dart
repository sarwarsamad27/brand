class ComLoginModel {
  String? message;
  Company? company;

  ComLoginModel({this.message, this.company});

  ComLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Company {
  String? id;
  String? name;
  String? email;

  Company({this.id, this.name, this.email});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
