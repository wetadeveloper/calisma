import 'package:final_hazirlik/services/notesapp_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/notesapp_employee.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';

class EmployeeRegistrationScreen extends StatefulWidget {
  @override
  _EmployeeRegistrationScreenState createState() => _EmployeeRegistrationScreenState();
}

class _EmployeeRegistrationScreenState extends State<EmployeeRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _identityNumber = '';
  String _department = '';
  double _salary = 0.0;
  String _address = '';
  int _workingYears = 0;
  File? _image;
  List<String> _employeesIdentityNumbers = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final employees = await DatabaseHelper.instance.getAllEmployees();
    setState(() {
      _employeesIdentityNumbers = employees.map((e) => e.identityNumber).toList();
    });
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final employee = Employee(
        name: _name,
        identityNumber: _identityNumber,
        department: _department,
        salary: _salary,
        address: _address,
        workingYears: _workingYears,
        imagePath: _image?.path,
      );
      await DatabaseHelper.instance.addEmployee(employee);
      _loadEmployees();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              if (_image != null) Image.file(_image!, width: 100, height: 100),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Resim Ekle'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kişi Adı'),
                onSaved: (value) => _name = value!,
                validator: (value) => value!.isEmpty ? 'Lütfen bir ad girin' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kişi TC. Kimlik No'),
                onSaved: (value) => _identityNumber = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kimlik numarası girin';
                  } else if (value.length != 11) {
                    return 'Kimlik numarası 11 haneli olmalıdır';
                  } else if (_employeesIdentityNumbers.contains(value)) {
                    return 'Bu kimlik numarası zaten kayıtlı';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kişi Departman'),
                onSaved: (value) => _department = value!,
                validator: (value) => value!.isEmpty ? 'Lütfen departman girin' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kişi Maaş'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _salary = double.tryParse(value!) ?? 0.0,
                validator: (value) => value!.isEmpty ? 'Lütfen maaş girin' : null,
              ),
              Text("Çalışma Yılı: "),
              Slider(
                value: _workingYears.toDouble(),
                min: 0,
                max: 30,
                divisions: 30,
                label: ' ${_workingYears.toString()}',
                onChanged: (newValue) {
                  setState(() {
                    _workingYears = newValue.round();
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Adres'),
                controller: TextEditingController(text: _address),
                onSaved: (value) {
                  if (value != null) _address = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adres girin';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _saveEmployee,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
