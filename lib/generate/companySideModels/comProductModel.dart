class ComProductModel {
  String? message;
  int? count;
  List<Product>? products;

  ComProductModel({this.message, this.count, this.products});

  ComProductModel.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? productDescription;
  int? price;
  int? stock;
  int? discount;
  String? category;
  List<String>? images;
  String? brand;
  String? user;
  String? sId;
  int? iV;

  Product({
    this.productName,
    this.productDescription,
    this.price,
    this.stock,
    this.discount,
    this.category,
    this.images,
    this.brand,
    this.user,
    this.sId,
    this.iV,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productDescription = json['productDescription'];
    price = json['price'];
    stock = json['stock'];
    discount = json['discount'];
    category = json['category'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    brand = json['brand'];
    user = json['user'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    data['price'] = price;
    data['stock'] = stock;
    data['discount'] = discount;
    data['category'] = category;
    data['images'] = images;
    data['brand'] = brand;
    data['user'] = user;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
