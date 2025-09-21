class AllProductModel {
  int? count;
  List<Products>? products;

  AllProductModel({this.count, this.products});

  AllProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? productName;
  String? productDescription;
  int? price;
  int? stock;
  int? discount;
  String? category;
  List<String>? images;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? brand;

  Products({
    this.sId,
    this.productName,
    this.productDescription,
    this.price,
    this.stock,
    this.discount,
    this.category,
    this.images,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.brand,
  });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    price = json['price'];
    stock = json['stock'];
    discount = json['discount'];
    category = json['category'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    data['price'] = price;
    data['stock'] = stock;
    data['discount'] = discount;
    data['category'] = category;
    data['images'] = images;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['brand'] = brand;
    return data;
  }
}
