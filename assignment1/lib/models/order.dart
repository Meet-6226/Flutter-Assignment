enum OrderStatus { pending, preparing, delivered, cancelled }

class OrderItem {
  final String foodName;
  final int quantity;
  final double price;

  const OrderItem({
    required this.foodName,
    required this.quantity,
    required this.price,
  });
}

class OrderModel {
  final String id;
  final String customerName;
  final List<OrderItem> items;
  final double totalPrice;
  final String dateTime;
  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.customerName,
    required this.items,
    required this.totalPrice,
    required this.dateTime,
    required this.status,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
