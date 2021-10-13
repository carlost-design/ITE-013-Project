import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';

import 'dart:async';
import 'dart:convert';

Future<User> createUser(
    String first_name, String last_name, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.100.4/api/create.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to create user. ${response.statusCode}. ${response.body}');
  }
}

class User {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? password;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      password: json['password'],
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  Future<User>? _futureUser;

  bool _passwordVisible = true;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwController = TextEditingController();

  Widget regFailAlert(AsyncSnapshot<User> snapshot) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
        title: Text('Register Failed'),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('''Please try again later.
              ${snapshot.error}'''),
        ),
      );

  Widget regSucessAlert(AsyncSnapshot<User> snapshot) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
        title: Text('Register Success'),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Returning to login page.'),
        ),
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Mobile.png'),
                 fit:BoxFit.fill,
                ),
              ),
              child:
                  (_futureUser == null) ? buildForm() : buildFutureBuilder()),
        ),
      );

  SingleChildScrollView buildForm() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200.0),
                TextFormField(
                  validator: RequiredValidator(errorText: 'Field Required'),
                  controller: fnameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white54,
                    filled: true,
                    labelText: 'First Name',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  validator: RequiredValidator(errorText: 'Field Required'),
                  controller: lnameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white54,
                    filled: true,
                    labelText: 'Last Name',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Field Required"),
                    EmailValidator(
                        errorText: "Please enter a valid email address"),
                  ]),
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white54,
                    filled: true,
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  validator: MultiValidator([
                    MinLengthValidator(8,
                        errorText:
                            "Password must contain atleast 8 characters"),
                  ]),
                  controller: passwController,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    fillColor: Colors.white54,
                    filled: true,
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                      primary: Colors.deepOrange, // background
                                      onPrimary: Colors.white, // foreground
                                     ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _futureUser = createUser(
                                      fnameController.text,
                                      lnameController.text,
                                      emailController.text,
                                      passwController.text);
                                });
                              }
                            },
                            child: Text('REGISTER NOW'))),
                  ],
                ),
                SizedBox(height: 10.0),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login.'),
                ),
              ],
            ),
          ),
        ),
      );

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return regSucessAlert(snapshot);
        } else if (snapshot.hasError) {
          return regFailAlert(snapshot);
        }

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
