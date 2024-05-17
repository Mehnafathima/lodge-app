import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lodge_management_app/models/room.dart';
import 'package:lodge_management_app/services/firebase_service.dart';

class BookingPage extends StatefulWidget {
  final Room room;

  const BookingPage({Key? key, required this.room}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late TextEditingController _rentController;
  late TextEditingController _advanceController;
  late List<String> _customerNames = [];
  String _selectedCustomer = '';
  String _selectedPaymentMode = 'Cash';
  DateTime _selectedFromDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _rentController = TextEditingController();
    _advanceController = TextEditingController();
    _fetchCustomers();
  }

  @override
  void dispose() {
    _rentController.dispose();
    _advanceController.dispose();
    super.dispose();
  }

  Future<void> _fetchCustomers() async {
    final customersSnapshot =
        await FirebaseFirestore.instance.collection('customers').get();
    final List<String> customerNames =
        customersSnapshot.docs.map((doc) => doc['name'] as String).toList();

    setState(() {
      _customerNames = customerNames;
      _selectedCustomer = customerNames.isNotEmpty ? customerNames[0] : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Book ${widget.room.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCustomer,
                onChanged: (value) {
                  setState(() {
                    _selectedCustomer = value!;
                  });
                },
                items: _buildCustomerDropdownItems(),
                decoration: InputDecoration(
                  labelText: 'Select Customer',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Room: ${widget.room.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _rentController,
                decoration: InputDecoration(
                  labelText: 'Rent per Day',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMode,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value!;
                  });
                },
                items: ['Cash', 'GPay'].map((mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(mode),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Payment Mode',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('From Date', style: TextStyle(fontSize: 16)),
                      subtitle: Text(
                        '${_selectedFromDate.day}/${_selectedFromDate.month}/${_selectedFromDate.year}',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: _selectFromDate,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ListTile(
                      title: Text('End Date', style: TextStyle(fontSize: 16)),
                      subtitle: Text(
                        '${_selectedEndDate.day}/${_selectedEndDate.month}/${_selectedEndDate.year}',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: _selectEndDate,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _advanceController,
                decoration: InputDecoration(
                  labelText: 'Advance',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmBooking,
                child: Text('Confirm Booking', style: TextStyle(fontSize: 18)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildCustomerDropdownItems() {
    return _customerNames.map((name) {
      return DropdownMenuItem<String>(
        value: name,
        child: Text(name),
      );
    }).toList();
  }

  void _selectFromDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedFromDate = pickedDate;
      });
    }
  }

  void _selectEndDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedFromDate,
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  void _confirmBooking() {
    final Map<String, dynamic> bookingData = {
      'customerId': _selectedCustomer,
      'room': widget.room.name,
      'rentPerDay': double.parse(_rentController.text),
      'paymentMode': _selectedPaymentMode,
      'fromDate': _selectedFromDate,
      'endDate': _selectedEndDate,
      'advance': double.parse(_advanceController.text),
    };

    FirebaseService().saveBookingData(bookingData);

    final updatedRoom = widget.room.copyWith(status: false);
    FirebaseService().updateRoomStatus(updatedRoom);

    Navigator.pop(context);
  }
}
