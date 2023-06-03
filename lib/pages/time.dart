import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _firstColor = Color(0xffe84a5f);
const _secondColor = Color(0xff252525);

class TimeConversionPage extends StatefulWidget {
  const TimeConversionPage({super.key});

  @override
  State<TimeConversionPage> createState() => _TimeConversionPageState();
}

String selectedValue = "WIB";

class _TimeConversionPageState extends State<TimeConversionPage> {
  late DateTime _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    // update the current time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (selectedValue == "WITA") {
          _currentTime = DateTime.now().add(const Duration(hours: 1));
        } else if (selectedValue == "BST") {
          _currentTime = DateTime.now().subtract(const Duration(hours: 6));
        } else if (selectedValue == "WIT") {
          _currentTime = DateTime.now().add(const Duration(hours: 2));
        } else {
          _currentTime = DateTime.now();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  _operationDropdown(),
                  const SizedBox(height: 20),
                  const Text(
                    'Waktu :',
                    style: TextStyle(
                      color: _firstColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('HH:mm:ss ').format(_currentTime),
                        style: const TextStyle(
                          color: _firstColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedValue,
                        style: const TextStyle(
                          color: _firstColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _operationDropdown() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 200,
      child: DropdownButtonFormField(
        value: selectedValue,
        items: dropdownItems,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _firstColor, width: 3),
          ),
          filled: true,
          fillColor: _secondColor,
          focusColor: Colors.black,
        ),
        dropdownColor: _secondColor,
        style: const TextStyle(color: _firstColor, fontWeight: FontWeight.bold),
        iconEnabledColor: _firstColor,
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: "WIB",
        child: Text("WIB"),
      ),
      const DropdownMenuItem(
        value: "WITA",
        child: Text("WITA"),
      ),
      const DropdownMenuItem(
        value: "WIT",
        child: Text("WIT"),
      ),
      const DropdownMenuItem(
        value: "BST",
        child: Text("BST"),
      ),
    ];
    return menuItems;
  }
}
