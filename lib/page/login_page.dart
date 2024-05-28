import 'package:face_recognition/utils/local_db.dart';
import 'package:face_recognition/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    printIfDebug(LocalDB.getUser().name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Face Authentication"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(
                  text: "Register",
                  icon: Icons.app_registration_rounded,
                  onClicked: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FaceScreen()));
                  }),
              const SizedBox(
                height: 24,
              ),
              buildButton(
                  text: "Login",
                  icon: Icons.app_registration_rounded,
                  onClicked: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FaceScanScreen(user: LocalDB.getUser())));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildButton(
        {required String text,
        required IconData icon,
        required VoidCallback onClicked}) =>
    ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      icon: Icon(
        icon,
        size: 26,
      ),
      label: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
