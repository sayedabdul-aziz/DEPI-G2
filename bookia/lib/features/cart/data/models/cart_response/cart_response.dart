import 'cart_item.dart';
import 'user.dart';

class CartResponse {
  int? id;
  User? user;
  dynamic total;
  List<CartItem>? cartItems;

  CartResponse({this.id, this.user, this.total, this.cartItems});

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    id: json['id'] as int?,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    total: json['total'] as dynamic,
    cartItems: (json['cart_items'] as List<dynamic>?)
        ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': user?.toJson(),
    'total': total,
    'cart_items': cartItems?.map((e) => e.toJson()).toList(),
  };
}
