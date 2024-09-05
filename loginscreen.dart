import 'package:abmbulance/components/button.dart';
import 'package:abmbulance/components/text_field.dart';
import 'package:abmbulance/components/text_password_field.dart';
import 'package:abmbulance/view/home_screen.dart';
import 'package:abmbulance/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // bool _isPasswordVisible = false;
  // TextEditingController _passwordController = TextEditingController();

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _isPasswordVisible = !_isPasswordVisible;
  //   });
  // }

  bool isPassword = true;

  //logic
  void login() async {
    String email = emailController.text;
    String password = passwordController.text;
    List<Map<String, dynamic>> user = await retrieveUser(email, password);
    if (user.isNotEmpty) {
      print("Login successful");
    } else {
      print("Invalid username or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image(image: AssetImage('assets/login.png')),
                  SizedBox(
                    height: 10,
                  ),
                  textField(
                    controller: emailController,
                    hintText: 'Enter your email address',
                    validateText: 'It must contain your email address',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textField(
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    validateText: "It must contain your password",
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: isPassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    isPassword: isPassword,
                    onPressedSuffix: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget Password?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  button(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    },
                    btnName: 'LOGIN',
                    btnHeight: 55,
                    fontSize: 23,
                    textColor: Colors.white,
                    btnColor: Color(0xFFFF3F3F),
                    btnWidth: 200,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //database creation
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT NOT NULL, cnic_number TEXT NOT NULL, phone_number TEXT NOT NULL, password TEXT NOT NULL, full_name TEXT NOT NULL, address TEXT NOT NULL, city TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

//insert into Database
  Future<void> insertUser(
    String email,
    String password,
  ) async {
    final Database db = await initializeDB();
    await db.insert(
      'users',
      {
        'email': emailController,
        'password': passwordController,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//retreive users from database
  Future<List<Map<String, dynamic>>> retrieveUser(
    String email,
    String password,
  ) async {
    final Database db = await initializeDB();
    return await db.query(
      'users',
      where: "email = ? AND password = ?",
      whereArgs: [
        emailController,
        passwordController,
      ],
    );
  }

//update Database
  Future<void> updateDatabase() async {}
}
