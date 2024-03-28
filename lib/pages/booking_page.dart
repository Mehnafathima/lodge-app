import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lodge_management_app/models/booking.dart';
import 'package:lodge_management_app/models/customer.dart';
import 'package:lodge_management_app/models/room.dart';
import 'package:lodge_management_app/pages/main_page.dart';
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
  late List<String> _customerNames = []; // List to store customer names

  String _selectedCustomer = ''; // Initially empty
  String _selectedPaymentMode = 'Cash'; // Default payment mode

  DateTime _selectedFromDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _rentController = TextEditingController();
    _advanceController = TextEditingController();
    _fetchCustomers(); // Call method to fetch customers on initialization
  }

  @override
  void dispose() {
    _rentController.dispose();
    _advanceController.dispose();
    super.dispose();
  }

  Future<void> _fetchCustomers() async {
    // Fetch customer data from Firestore collection
    final customersSnapshot =
        await FirebaseFirestore.instance.collection('customers').get();

    // Extract customer names from snapshot
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
      appBar: AppBar(
        title: Text('Book ${widget.room.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCustomer,
                onChanged: (value) {
                  setState(() {
                    _selectedCustomer = value!;
                  });
                },
                items:
                    _buildCustomerDropdownItems(), // Implement this method to fetch customer data
                decoration: const InputDecoration(
                  labelText: 'Select Customer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Room: ${widget.room.name}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _rentController,
                decoration: const InputDecoration(
                  labelText: 'Rent per Day',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
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
                decoration: const InputDecoration(
                  labelText: 'Payment Mode',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('From Date'),
                      subtitle: Text(
                        '${_selectedFromDate.day}/${_selectedFromDate.month}/${_selectedFromDate.year}',
                      ),
                      onTap: _selectFromDate,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ListTile(
                      title: const Text('End Date'),
                      subtitle: Text(
                        '${_selectedEndDate.day}/${_selectedEndDate.month}/${_selectedEndDate.year}',
                      ),
                      onTap: _selectEndDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _advanceController,
                decoration: const InputDecoration(
                  labelText: 'Advance',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmBooking,
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
List<DropdownMenuItem<String>> _buildCustomerDropdownItems() {
    // Map customer names to DropdownMenuItem<String> widgets
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
  // Create booking data object
  final Map<String, dynamic> bookingData = {
    'customerId': _selectedCustomer, // Assuming _selectedCustomer is a Customer object with an id property
    'room': widget.room.name,
    'rentPerDay': double.parse(_rentController.text),
    'paymentMode': _selectedPaymentMode,
    'fromDate': _selectedFromDate,
    'endDate': _selectedEndDate,
    'advance': double.parse(_advanceController.text),
  };

  // Save booking data to Firebase
  FirebaseService().saveBookingData(bookingData);

  // Update room status to false
  final updatedRoom = widget.room.copyWith(status: false);
  FirebaseService().updateRoomStatus(updatedRoom);

  // Navigate back to the main page
   Navigator.pop(context);

}


}
