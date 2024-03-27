
class Customer {
  final String id;
  final String name;
  final String phoneNumber;
  final String idType;
  final String idNumber;

  Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.idType,
    required this.idNumber,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      idType: map['idType'],
      idNumber: map['idNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'idType': idType,
      'idNumber': idNumber,
    };
  }
}
