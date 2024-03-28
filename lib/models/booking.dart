class Booking {
  final String id;
  final String customerId;
  final String roomId;
  final double rentPerDay;
  final String paymentMode;
  final DateTime fromDate;
  final DateTime toDate;
  final double advance;

  Booking({
    required this.id,
    required this.customerId,
    required this.roomId,
    required this.rentPerDay,
    required this.paymentMode,
    required this.fromDate,
    required this.toDate,
    required this.advance,
  });

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      customerId: map['customerId'],
      roomId: map['roomId'],
      rentPerDay: map['rentPerDay'],
      paymentMode: map['paymentMode'],
      fromDate: map['fromDate'].toDate(),
      toDate: map['toDate'].toDate(),
      advance: map['advance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'roomId': roomId,
      'rentPerDay': rentPerDay,
      'paymentMode': paymentMode,
      'fromDate': fromDate,
      'toDate': toDate,
      'advance': advance,
    };
  }
  
}
