class ComEntryProductShowModel {
  String? message;
  int? count;
  List<Product>? products;

  ComEntryProductShowModel({this.message, this.count, this.products});

  ComEntryProductShowModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['count'] = count;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['image'] = image;
    data['user'] = user;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
