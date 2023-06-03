import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_api_indonesia/pages/list.dart';
import 'package:weather_api_indonesia/pages/logout.dart';
import 'package:weather_api_indonesia/widget/drawer.dart';

const _firstColor = Color(0xffe84a5f);
const _secondColor = Color(0xff252525);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> pages = const [
    ListPage(),
    Logout(),
  ];

  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(bool isCamera) async {
    final XFile? image;
    if (isCamera) {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      setState(() {
        _imagePath = image?.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _mainBody(),
      drawer: const NavigationDrawerWidget(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        '123200120 - Tugas Akhir',
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: _secondColor,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          height: 45,
          width: 45,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.camera_alt_rounded),
          color: _firstColor,
          onPressed: () async {
            await getImage(true);
          },
        ),
        const SizedBox(
          width: 15,
        ),
      ],
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: _firstColor,
        ),
        onPressed: () {
          const NavigationDrawerWidget();
        },
      ),
    );
  }

  Widget _mainBody() {
    return SafeArea(
      child: Container(
        color: _firstColor,
        alignment: Alignment.topLeft,
        child: pages[_currentIndex],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: _firstColor,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            color: _firstColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        indicatorShape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: NavigationBar(
        height: 90,
        backgroundColor: _secondColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: _secondColor,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: _firstColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.logout,
              color: _secondColor,
            ),
            icon: Icon(
              Icons.logout_outlined,
              color: _firstColor,
            ),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  void openCamera() async {
    // Check if camera permission is granted
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (!cameraPermissionStatus.isGranted) {
      // Request camera permission
      cameraPermissionStatus = await Permission.camera.request();
      if (!cameraPermissionStatus.isGranted) {
        // Permission denied, handle accordingly
        print('Camera permission denied.');
        return;
      }
    }

    // Open camera using ImagePicker
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Do something with the image file
      print('Image captured: ${pickedFile.path}');
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_imagePath', _imagePath));
  }
}
