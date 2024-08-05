
class StockLog {
  final String id;
  final String productName;
  final String batch;
  final int quantity;
  final DateTime registrationDate;
  
  StockLog({
    required this.id,
    required this.productName,
    required this.batch,
    required this.quantity,
    required this.registrationDate
  });
}