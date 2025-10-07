class CompFormModel {
  String? message;
  Profile? profile;

  CompFormModel({this.message, this.profile});

  CompFormModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? sId;
  String? email;
  int? iV;
  String? address;
  String? description;
  String? image;
  String? mobile;
  String? name;

  Profile(
      {this.sId,
      this.email,
      this.iV,
      this.address,
      this.description,
      this.image,
      this.mobile,
      this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    iV = json['__v'];
    address = json['address'];
    description = json['description'];
    image = json['image'];
    mobile = json['mobile'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['__v'] = this.iV;
    data['address'] = this.address;
    data['description'] = this.description;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    return data;
  }
}
