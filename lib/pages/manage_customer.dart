import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart'; 

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idTypeController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C U S T O M E R'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('customers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<QueryDocumentSnapshot> customerDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: customerDocs.length,
              itemBuilder: (context, index) {
                var customerData =
                    customerDocs[index].data() as Map<String, dynamic>;
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      customerData['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(customerData['phone']),
                    trailing: Wrap(
                      spacing: -16, // space between two icons

                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _nameController.text = customerData['name'];
                            _dobController.text = customerData['dob'];
                            _phoneController.text = customerData['phone'];
                            _idTypeController.text = customerData['idType'];
                            _idNumberController.text = customerData['idNumber'];
                            _showCustomerFormModal(context,
                                customerId: customerDocs[index].id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteCustomer(customerDocs[index].id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            _callCustomer(customerData['phone']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCustomerFormModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  DateTime? _selectedDate;

  void _showCustomerFormModal(BuildContext context, {String? customerId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerId == null ? 'Add Customer' : 'Edit Customer',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Customer Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _dobController.text = DateFormat('yyyy-MM-dd')
                                  .format(
                                      pickedDate); // Format date as YYYY-MM-DD
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _idTypeController,
                    decoration: const InputDecoration(
                      labelText: 'ID Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _idNumberController,
                    decoration: const InputDecoration(
                      labelText: 'ID Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (customerId == null) {
                            _addCustomer();
                          } else {
                            _updateCustomer(customerId);
                          }
                          Navigator.pop(context); // Close dialog
                        },
                        child: Text(customerId == null ? 'Add' : 'Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addCustomer() {
    _firestore.collection('customers').add({
      'name': _nameController.text,
      'dob': _dobController.text,
      'phone': _phoneController.text,
      'idType': _idTypeController.text,
      'idNumber': _idNumberController.text,
    });
    _clearForm();
  }

  void _updateCustomer(String customerId) {
    _firestore.collection('customers').doc(customerId).update({
      'name': _nameController.text,
      'dob': _dobController.text,
      'phone': _phoneController.text,
      'idType': _idTypeController.text,
      'idNumber': _idNumberController.text,
    });
    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _dobController.clear();
    _phoneController.clear();
    _idTypeController.clear();
    _idNumberController.clear();
  }


void _callCustomer(String phoneNumber) async {
  const String countryCode = '+91';
  final String formattedPhoneNumber = '$countryCode$phoneNumber';
  final Uri phoneUri = Uri.parse('tel:$formattedPhoneNumber');

  try {
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch phone dialer for $formattedPhoneNumber';
    }
  } on PlatformException catch (e) {
    // Handle platform-specific exceptions (optional)
    print('PlatformException: $e');
    throw 'Could not launch phone dialer for $formattedPhoneNumber';
  } catch (e) {
    // Handle other exceptions
    print('Error launching phone dialer: $e');
    throw 'Could not launch phone dialer for $formattedPhoneNumber';
  }
}






  void _deleteCustomer(String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this customer?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _firestore.collection('customers').doc(customerId).delete();
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
