import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Reading Timetable'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const ScheduleForm(),
    );
  }
}

class ScheduleForm extends StatefulWidget {
  const ScheduleForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final _formKey = GlobalKey<FormState>();
  final _schedules = <Map<String, String>>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Day of the week',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a day';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      setState(() {
                        _schedules.add({'day': value});
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Time slot',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a time slot';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      setState(() {
                        _schedules[_schedules.length - 1]['time'] = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text('Submit'),
        ),
        Expanded(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Day'),
              ),
              DataColumn(
                label: Text('Time Slot'),
              ),
            ],
            rows: _schedules.map((schedule) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(schedule['day'] ?? '')),
                  DataCell(Text(schedule['time'] ?? '')),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
