class CreateComProductModel {
  String? message;
  Product? product;

  CreateComProductModel({this.message, this.product});

  CreateComProductModel.fromJson(Map<String, dynamic> json) {
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

  Product(
      {this.productName,
      this.productDescription,
      this.price,
      this.stock,
      this.discount,
      this.category,
      this.images,
      this.brand,
      this.user,
      this.sId,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productDescription = json['productDescription'];
    price = json['price'];
    stock = json['stock'];
    discount = json['discount'];
    category = json['category'];
    images = json['images'].cast<String>();
    brand = json['brand'];
    user = json['user'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['discount'] = this.discount;
    data['category'] = this.category;
    data['images'] = this.images;
    data['brand'] = this.brand;
    data['user'] = this.user;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
