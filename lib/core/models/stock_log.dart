class StockLog {
  final String id;
  final String action;
  final DateTime date;
  final int quantity;
  final String registeredBy;
  final String productId;
  final String productName;

  StockLog({
    required this.id,
    required this.action,
    required this.date,
    required this.quantity,
    required this.registeredBy,
    required this.productId,
    required this.productName,
  });
}