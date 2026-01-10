class InvoiceEntity {
  final String invoiceId;
  final String date;
  final double totalAmount;

  const InvoiceEntity({
    required this.invoiceId,
    required this.date,
    required this.totalAmount,
  });
}
