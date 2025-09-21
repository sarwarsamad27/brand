class ComProductEntryModel {
  String? message;
  Product? product;

  ComProductEntryModel({this.message, this.product});

  ComProductEntryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? name;
  String? image;
  String? user;
  String? sId;
  int? iV;

  Product({this.name, this.image, this.user, this.sId, this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    user = json['user'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['user'] = this.user;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
