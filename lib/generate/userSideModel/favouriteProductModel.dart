class FavouriteProductModel {
  int? count;
  List<Favourites>? favourites;
  String? message;

  FavouriteProductModel({this.count, this.favourites, this.message});

  FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['favourites'] != null) {
      favourites = <Favourites>[];
      json['favourites'].forEach((v) {
        favourites!.add(Favourites.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (favourites != null) {
      data['favourites'] = favourites!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Favourites {
  String? sId;
  Product? product;
  dynamic company;

  /// ✅ local field for quantity
  int quantity;

  Favourites({this.sId, this.product, this.company, this.quantity = 1});

  Favourites.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'] ?? 1 {
    sId = json['_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (product != null) data['product'] = product!.toJson();
    data['company'] = company;
    data['quantity'] = quantity;
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  String? productDescription;
  int? price;
  int? stock;
  int? discount;
  String? category;
  List<String>? images;

  Product({
    this.sId,
    this.productName,
    this.productDescription,
    this.price,
    this.stock,
    this.discount,
    this.category,
    this.images,
  });

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    price = json['price'];
    stock = json['stock'];
    discount = json['discount'];
    category = json['category'];
    images = (json['images'] as List?)?.map((e) => e.toString()).toList();
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
    return data;
  }
}
