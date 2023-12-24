import 'package:flutter/material.dart';


class ActivityForm extends StatefulWidget {
  final List<Map<String, String>> schedules;

  const ActivityForm({super.key, required this.schedules});

  @override
  // ignore: library_private_types_in_public_api
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();
  final _activities = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Activities'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ...widget.schedules.map((schedule) {
                return Column(
                  children: <Widget>[
                    Text('Day: ${schedule['day']}, Time Slot: ${schedule['time']}'),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Activity',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an activity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          setState(() {
                            _activities.add(value);
                          });
                        }
                      },
                    ),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // background color
                  foregroundColor: Colors.white, // foreground color
                ),
                child: const Text('Submit'),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Activity')),
                ],
                rows: _activities.map((activity) => DataRow(cells: [DataCell(Text(activity))])).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
