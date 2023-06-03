import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/model/currency_model.dart';

const _firstColor = Color(0xffe84a5f);
const _secondColor = Color(0xff252525);

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({Key? key}) : super(key: key);

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

String convertCurrencies(
  String firstCurrency,
  String secondCurrency,
  String amount,
) {
  double? doubleCurrency1 = double.tryParse(firstCurrency);
  double? doubleCurrency2 = double.tryParse(secondCurrency);
  double? doubleAmount = double.tryParse(amount);

  if (doubleCurrency1 != null &&
      doubleCurrency2 != null &&
      doubleAmount != null) {
    double result = doubleAmount * doubleCurrency2 / doubleCurrency1;
    return result.toString();
  } else {
    return 'Invalid input';
  }
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final currencies = Currencies();
  final _inputValueController = TextEditingController();

  Future<Currencies>? currencyData;

  String firstCurrencyValue = "1";
  String secondCurrencyValue = "1";
  String convertedResult = "";

  double? firstCurrency;
  double? secondCurrency;
  double? thirdCurrency;
  double? fourthCurrency;

  @override
  void initState() {
    super.initState();
    print(firstCurrency);
    late Map<String, double>? currencyRates;
    currencyData = Currencies.fetchCurrencies();
    print(currencyData);
    currencyData!.then((currencies) {
      currencyRates = currencies.rates;
      print("rates : $currencyRates");
      setState(() {
        firstCurrencyValue = currencyRates!['USD']?.toString() ?? '1';
        secondCurrencyValue = currencyRates!['USD']?.toString() ?? '1';

        firstCurrency = currencyRates!['USD'];
        print(firstCurrency);
        secondCurrency = currencyRates!['IDR'];
        print(secondCurrency);
        thirdCurrency = currencyRates!['EUR'];
        print(thirdCurrency);
        fourthCurrency = currencyRates!['JPY'];
        print(fourthCurrency);
      });
    });
    // print('Outside : $currencyBase');
  }

  void swapCurrencies() {
    setState(() {
      String temp = firstCurrencyValue;
      firstCurrencyValue = secondCurrencyValue;
      secondCurrencyValue = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currencies')),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 300,
              child: TextFormField(
                controller: _inputValueController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: _firstColor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  filled: true,
                  fillColor: _secondColor,
                  focusColor: _firstColor,
                  hintText: 'Masukkan value',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _firstDropdown(),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    swapCurrencies();
                  },
                  backgroundColor: _firstColor,
                  child: const Icon(
                    Icons.swap_horiz,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                _secondDropdown(),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 80,
              width: 120,
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Result : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    convertedResult,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: _firstColor,
                  backgroundColor: _secondColor,
                  shadowColor: Colors.black,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(90, 40),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    color: _firstColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(
                    () {
                      convertedResult = convertCurrencies(
                        firstCurrencyValue,
                        secondCurrencyValue,
                        _inputValueController.text,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstDropdown() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 100,
      child: DropdownButtonFormField<String>(
        value: firstCurrencyValue,
        items: dropdownItems,
        onChanged: (String? newValue) {
          setState(() {
            firstCurrencyValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: _firstColor,
            ),
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: _secondColor,
          labelText: 'Currency',
          labelStyle: const TextStyle(
            color: _firstColor,
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _secondDropdown() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 100,
      child: DropdownButtonFormField<String>(
        value: secondCurrencyValue,
        items: dropdownItems,
        onChanged: (String? newValue) {
          setState(() {
            secondCurrencyValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: _firstColor,
            ),
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: _secondColor,
          labelText: 'Currency',
          labelStyle: const TextStyle(
            color: _firstColor,
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: firstCurrency != null ? firstCurrency.toString() : '1',
        child: const Text("USD"),
      ),
      DropdownMenuItem(
        value:
            secondCurrency != null ? secondCurrency.toString() : '14859.295505',
        child: const Text("IDR"),
      ),
      DropdownMenuItem(
        value: thirdCurrency != null ? thirdCurrency.toString() : '0.92021',
        child: const Text("EUR"),
      ),
      DropdownMenuItem(
        value: fourthCurrency != null ? fourthCurrency.toString() : '136.3845',
        child: const Text("JPY"),
      ),
    ];
    return menuItems;
  }
}
