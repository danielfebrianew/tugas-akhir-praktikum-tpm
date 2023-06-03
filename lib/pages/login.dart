import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_api_indonesia/pages/home.dart';
import 'package:weather_api_indonesia/pages/register.dart';
import 'package:weather_api_indonesia/widget/encryption.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

const _firstColor = Color(0xffe84a5f);
const _secondColor = Color(0xff252525);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  void dispose() {
    Hive.box('users').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(35, 40, 40, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: _secondColor,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  _textMasuk(),
                  const SizedBox(
                    height: 50,
                  ),
                  _emailField(),
                  const SizedBox(
                    height: 25,
                  ),
                  _passwordField(),
                  const SizedBox(
                    height: 45,
                  ),
                  _loginButton(),
                  const SizedBox(
                    height: 30,
                  ),
                  _buttonDaftar(),
                  // _deleteAll(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textMasuk() {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Masuk',
        style: TextStyle(
          color: _firstColor,
          fontSize: 45,
          fontFamily: 'Arial',
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emailField() {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        controller: _emailController,
        validator: (value) {
          if (value!.isEmpty || !value.contains('@')) {
            return 'Please Enter a valid Email!';
          } else {
            return null;
          }
        },
        enabled: true,
        style: const TextStyle(
          color: _firstColor,
        ),
        cursorColor: _firstColor,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.email,
            color: _firstColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: _firstColor,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusColor: Colors.white,
          filled: true,
          fillColor: const Color.fromARGB(255, 14, 14, 14),
          hintText: 'Email',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        // key: const ValueKey('password'),
        controller: _passwordController,
        validator: (value) {
          if (value!.isEmpty || value.length < 6) {
            return 'Please Enter a Password of min length!';
          } else {
            return null;
          }
        },
        enabled: true,
        style: const TextStyle(
          color: _firstColor,
        ),
        cursorColor: _firstColor,
        obscureText: _obscureText,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.key,
            color: _firstColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: _firstColor,
              width: 3,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          filled: true,
          fillColor: const Color.fromARGB(255, 14, 14, 14),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: _firstColor,
            ),
          ),
          hintText: 'Password',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: _firstColor,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () async {
          if (Hive.isBoxOpen('users')) {
            bool isUserExist = await checkUser(
                _emailController.text, _passwordController.text);

            if (isUserExist == true && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Either your Email or Password is incorrect!'),
                ),
              );
            }
          } else {
            await Hive.openBox('users');

            bool isUserExist = await checkUser(
                _emailController.text, _passwordController.text);

            if (isUserExist == true && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Either your Email or Password is incorrect!'),
                ),
              );
            }
          }

          print(_emailController.text);
          print(_passwordController.text);
        },
        child: const Text(
          'Masuk',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // Widget _deleteAll() {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: Colors.black,
  //         backgroundColor: _firstColor,
  //         elevation: 3,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         minimumSize: const Size(double.infinity, 50),
  //       ),
  //       onPressed: () async {
  //         // Call the deleteHiveDatabase function to delete all data
  //         await deleteHiveDatabase();

  //         if (context.mounted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('All data deleted from Hive database!'),
  //             ),
  //           );
  //         }
  //       },
  //       child: const Text(
  //         'Delete All',
  //         style: TextStyle(
  //           fontSize: 18,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> deleteHiveDatabase() async {
    await Hive.openBox('users');
    // Get the application documents directory
    var user = Hive.box('users');

    await user.clear();
  }

  Widget _buttonDaftar() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Belum punya akun?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationPage(),
                ),
              );
            },
            child: const Text(
              'Daftar',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> checkUser(String mail, String pass) async {
    var user = Hive.box('users');
    final email = mail;
    final password = pass;

    // Fetch all users from the box
    final allUsers = user.values.toList();
    print("alluser : $allUsers");

    String encryptedPassword = CustomEncryption.enrcyptAES(password).toString();
    print("encrypted login : $encryptedPassword");

    // Check if there are matching email and password in the list of users
    final matchingUser = allUsers.any(
      (user) => user.email == email && user.password == encryptedPassword,
    );

    print("matching user $matchingUser");

    if (matchingUser == true) {
      return true;
    } else {
      return false;
    }
  }
}
