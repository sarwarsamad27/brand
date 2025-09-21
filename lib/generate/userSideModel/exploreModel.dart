class ExploreModel {
  int? count;
  List<Profiles>? profiles;

  ExploreModel({this.count, this.profiles});

  ExploreModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  String? sId;
  String? user;
  int? iV;
  String? address;
  String? description;
  String? email;
  String? image;
  String? mobile;
  String? name;

  Profiles(
      {this.sId,
      this.user,
      this.iV,
      this.address,
      this.description,
      this.email,
      this.image,
      this.mobile,
      this.name});

  Profiles.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    iV = json['__v'];
    address = json['address'];
    description = json['description'];
    email = json['email'];
    image = json['image'];
    mobile = json['mobile'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['__v'] = this.iV;
    data['address'] = this.address;
    data['description'] = this.description;
    data['email'] = this.email;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    return data;
  }
}
