class ProductShowModel {
  int? count;
  List<Products>? products;

  ProductShowModel({this.count, this.products, required String message});

  ProductShowModel.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? productDescription;
  int? price;
  int? stock;
  int? discount;
  String? category;
  List<String>? images;
  String? brand;
  String? user;
  int? iV;

  Products(
      {this.sId,
      this.productName,
      this.productDescription,
      this.price,
      this.stock,
      this.discount,
      this.category,
      this.images,
      this.brand,
      this.user,
      this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    price = json['price'];
    stock = json['stock'];
    discount = json['discount'];
    category = json['category'];
    images = json['images'].cast<String>();
    brand = json['brand'];
    user = json['user'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['discount'] = this.discount;
    data['category'] = this.category;
    data['images'] = this.images;
    data['brand'] = this.brand;
    data['user'] = this.user;
    data['__v'] = this.iV;
    return data;
  }
}
