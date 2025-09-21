class ProductEntryModel {
  int? count;
  List<Products>? products;

  ProductEntryModel({this.count, this.products});

  ProductEntryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? name;
  String? image;
  String? user;
  int? iV;

  Products({this.sId, this.name, this.image, this.user, this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    user = json['user'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['user'] = this.user;
    data['__v'] = this.iV;
    return data;
  }
}
