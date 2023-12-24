import 'package:flutter/material.dart';
import 'package:times_table/activities.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TB",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Reading Timetable'),
          backgroundColor: Colors.blueAccent,
        ),
        body: const ScheduleForm(),
      ),
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
    return Padding(
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ActivityForm(schedules: _schedules)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
