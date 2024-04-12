import 'package:MICEconnect/components/My_textfield.dart';
import 'package:flutter/material.dart';
import 'package:MICEconnect/Screens/home_screen.dart';
import 'package:MICEconnect/components/my_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = false;
  bool checkTheBox = false;

  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  void check() {
    setState(() {
      checkTheBox = !checkTheBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Image.asset(
                "assets/images/logo1.jpg",
                width: 200,
              ),
              SizedBox(height: 100),
              MyTextField(hintText: "Email"),
              SizedBox(height: 20),
              MyTextField(
                hintText: "Password",
                onPressed: showPassword,
                obsecureText: !showPass,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: checkTheBox,
                          onChanged: (value) {
                            check();
                          },
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        )
                      ],
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 123, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 100),
              MyButton(
                customColor: Color.fromARGB(255, 20, 135, 244),
                text: "Sign In",
                onTap: () {
                  // Navigasi ke HomeScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}