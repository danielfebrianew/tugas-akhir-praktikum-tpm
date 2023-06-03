import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_api_indonesia/model/user_model.dart';
import 'package:weather_api_indonesia/widget/encryption.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive User List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Hive.openBox("users"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      var users = Hive.box("users");

                      String defaultPassword =
                          CustomEncryption.enrcyptAES("daniel").toString();

                      print(defaultPassword);

                      // if (users.length == 0) {
                      //   users.add(
                      //       User("danielfebrian@gmail.com", defaultPassword));
                      // }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: ((context, index) {
                          print("user length ${users.length}");
                          User user = users.getAt(index);
                          return Column(
                            children: [
                              ListTile(
                                title: Text(user.email),
                                subtitle: Text(user.password),
                              ),
                              const Divider()
                            ],
                          );
                        }),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       foregroundColor: Colors.black,
            //       backgroundColor: Colors.white,
            //       shadowColor: Colors.black,
            //       elevation: 3,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       minimumSize: const Size(90, 40),
            //     ),
            //     child: const Text(
            //       'Logout',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
