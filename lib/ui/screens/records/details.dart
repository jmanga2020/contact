import 'package:contact_tracing/models/patientModel.dart';
import 'package:contact_tracing/services/cloud/operations.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:contact_tracing/ui/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  void initState() {
    _id = Uuid().v4();

    _idController = TextEditingController(text: _id);
    super.initState();
  }

  String _id, _age, _sex, _location, _status;
  TextEditingController _idController;
  TextEditingController _ageController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  List<String> _sexList = ['Male', 'Female'];
  List<String> _statusList = ['Positive', 'Negative'];
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? UniversalLoader(
            label: 'Submitting details, Please wait...',
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Patient Details'),
              centerTitle: true,
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 50,
                width: DeviceMetrics.deviceWidth(context),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: OutlinedButton(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            letterSpacing: 2, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _formKey.currentState.save();
                          try {
                            await CloudOperations.addToCloud(
                                serverPath: 'Records/$_id',
                                data: PatientModel(
                                        id: _id,
                                        age: _age,
                                        sex: _sex,
                                        location: _location,
                                        status: _status)
                                    .toMap());
                            setState(() {
                              _locationController.clear();
                              _ageController.clear();
                              _sex = null;
                              _id = Uuid().v4();
                              _idController = TextEditingController(text: _id);
                              _status = null;
                              _loading = false;
                            });
                            showSnack(context,
                                content: 'Patient Details submitted');
                          } catch (e) {
                            showSnack(context,
                                error: true, content: 'Please try again later');
                          }
                        }
                      }),
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _idController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'User Id',
                              contentPadding: EdgeInsets.all(20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            )),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: Text('Choose your gender'),
                              value: _sex,
                              icon: Icon(Icons.person),
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Please choose your gender',
                              onChanged: (value) {
                                setState(() {
                                  _sex = value;
                                });
                              },
                              items: _sexList
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text('$e')))
                                  .toList()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: Text('Patient Status'),
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Please choose your patient status',
                              value: _status,
                              icon: Icon(Icons.local_hospital),
                              onChanged: (value) {
                                setState(() {
                                  _status = value;
                                });
                              },
                              items: _statusList
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text('$e')))
                                  .toList()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: _ageController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? 'Please enter your age' : null,
                          onChanged: (value) => setState(() {
                            _age = value;
                          }),
                          decoration: InputDecoration(
                              labelText: 'Age',
                              contentPadding: EdgeInsets.all(20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: _locationController,
                          readOnly: false,
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (value) => setState(() {
                            _location = value;
                          }),
                          validator: (value) => value.isEmpty
                              ? 'Please enter your location'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Location',
                              contentPadding: EdgeInsets.all(20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
