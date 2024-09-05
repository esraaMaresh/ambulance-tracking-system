import 'package:abmbulance/components/button.dart';
import 'package:abmbulance/components/text_field.dart';
import 'package:abmbulance/components/text_password_field.dart';
import 'package:abmbulance/view/home_screen.dart';
import 'package:abmbulance/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isPhotoTaken = false;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _isPhotoTaken = true;
      });
      print('Picture saved to ${photo.path}');
    }
  }

  var emailController = TextEditingController();
  var cnicController = TextEditingController();
  var fullNameController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  // bool _isPasswordVisible = false;
  // TextEditingController _passwordController = TextEditingController();

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _isPasswordVisible = !_isPasswordVisible;
  //   });
  // }
  bool isPassword = true;
  String _selectedValue = 'Sanaa';

  List<String> _options = [
    'Sanaa',
    'Taiz',
    'Aden',
  ];

  void signUp(String email, String CNICnumber, String fullName, String phone,
      String password, String address, String city) async {
    await insertUser(
        email, CNICnumber, fullName, phone, password, address, city);
    print("User signed up successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(35),
                  child: Text(
                    'SIGNUP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Image(image: AssetImage('assets/signup.png')),
                SizedBox(
                  height: 10,
                ),
                textField(
                  controller: emailController,
                  hintText: 'Enter your email address',
                  validateText: 'It must cotain your email address',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 8,
                ),
                textField(
                    controller: cnicController,
                    hintText: 'CNIC Number',
                    validateText: 'It must cotain your CNIC number',
                    prefixIcon: Icons.card_membership,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: 8,
                ),
                textField(
                    controller: fullNameController,
                    hintText: 'Full Name',
                    validateText: 'It must cotain your full name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name),
                SizedBox(
                  height: 8,
                ),
                textField(
                    controller: phoneController,
                    hintText: 'Phone number',
                    validateText: 'It must cotain your phone number',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone),
                SizedBox(
                  height: 8,
                ),
                textField(
                  controller: passwordController,
                  hintText: "Enter Your Password",
                  validateText: "It must contain your password",
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: isPassword
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  isPassword: isPassword,
                  onPressedSuffix: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                textField(
                    controller: addressController,
                    hintText: 'Address',
                    validateText: 'It must contain your address',
                    prefixIcon: Icons.location_on_outlined,
                    keyboardType: TextInputType.streetAddress),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 65,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF3F3F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    style: TextStyle(color: Colors.white),
                    hint: Text(
                      'Select your city',
                      textAlign: TextAlign.center,
                    ),
                    dropdownColor: Color(0xFFFF3F3F),
                    value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                    },
                    items: _options.map((String option) {
                      return DropdownMenuItem(
                        child: Text(option),
                        value: option,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Stack(
                  children: [
                    Image(
                      image: AssetImage('assets/CNIC.png'),
                      height: 180,
                    ),
                    Positioned(
                      top: 60,
                      right: 20,
                      left: 20,
                      child: button(
                          onPressed: () {},
                          btnName: 'Upload Your Personal CNIC',
                          btnHeight: 55,
                          fontSize: 15,
                          textColor: Colors.white,
                          btnColor: Color(0xFFFF3F3F),
                          btnWidth: 250),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                button(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  btnName: 'SIGN UP',
                  btnHeight: 55,
                  fontSize: 19,
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
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
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
  Future<void> insertUser(String email, String cnic_number, String phone_number,
      String password, String full_name, String address, String city) async {
    final Database db = await initializeDB();
    await db.insert(
      'users',
      {
        'email': emailController,
        'cnic_number': cnicController,
        'phone_number': phoneController,
        'password': passwordController,
        'full_name': fullNameController,
        'address': addressController,
        'city': _selectedValue
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//retreive users from database
  Future<List<Map<String, dynamic>>> retrieveUser(
      String email,
      String cnic_number,
      String phone_number,
      String password,
      String full_name,
      String address,
      String city) async {
    final Database db = await initializeDB();
    return await db.query(
      'users',
      where:
          "email = ? AND cnic_number = ? AND phone_number = ? AND password = ? AND full_name = ? AND address = ? AND city = ?",
      whereArgs: [
        emailController,
        cnicController,
        phoneController,
        passwordController,
        fullNameController,
        addressController,
        _selectedValue
      ],
    );
  }

//update Database
  Future<void> updateDatabase() async {}
}
