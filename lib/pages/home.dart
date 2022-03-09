import 'package:flutter/material.dart';
import 'package:lab4/services/agify.dart';

class Home extends StatefulWidget {
  final AgifyServices _agifyService;

  const Home({Key? key})
      : _agifyService = const AgifyServices(),
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formkey = GlobalKey<FormState>();

  String? _name;
  int? _age;

  void onSubmit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      final calculatedAge = await widget._agifyService.getAgeFromName(_name!);

      setState(() {
        _age = calculatedAge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Agify",
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      helperText: "Name",
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? value) {
                      setState(() {
                        if (value != null) _name = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text("Get Age"),
                ),
              ],
            ),
          ),
          if (_age != null)
            Center(
              child: Text(
                "Age is $_age",
                style: Theme.of(context).textTheme.headline4,
              ),
            )
        ],
      ),
    );
  }
}
