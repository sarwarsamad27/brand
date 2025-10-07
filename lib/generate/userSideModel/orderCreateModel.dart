class OrderCreateModel {
  String? message;
  Order? order;

  OrderCreateModel({this.message, this.order});

  OrderCreateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? city;
  String? postalCode;
  String? address;
  List<Product>? products;
  String? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Order(
      {this.userId,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.postalCode,
      this.address,
      this.products,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    postalCode = json['postalCode'];
    address = json['address'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['address'] = address;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Product {
  String? product;
  int? quantity;
  String? sId;

  Product({this.product, this.quantity, this.sId});

  Product.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product'] = product;
    data['quantity'] = quantity;
    // ❌ _id null na bhejna
    if (sId != null) {
      data['_id'] = sId;
    }
    return data;
  }
}
