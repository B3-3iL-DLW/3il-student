import 'package:flutter/material.dart';

class BirthDateField extends StatefulWidget {
  const BirthDateField({super.key});

  @override
  BirthDateFieldState createState() => BirthDateFieldState();
}

class BirthDateFieldState extends State<BirthDateField> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 30.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date de naissance',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: _selectedDate.toLocal().toString().split(' ')[0],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(3.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).focusColor),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            onTap: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}
