import 'package:dashboard/sign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Updated backend IP and port
final myServerUrl = "http://192.168.24.170:9876";

// Register Screen
class Register extends StatelessWidget {
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Colors.amberAccent,
        ),
        body: Center(
          child: Text('Register Screen'),
        ));
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  final TextEditingController user_nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobile_noController = TextEditingController();

  Future<void> register() async {
    Uri url = Uri.parse('http://192.168.155.170:9876/user');

    var data = {
      'user_name': user_nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'mobile_no': mobile_noController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed to connect to the server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TooDoo')),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: user_nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      icon: Icon(Icons.people, color: Colors.white),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.amber),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.amber),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: mobile_noController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Phone No',
                      hintText: 'Enter your phone number',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: register,
                  child: Text('Register'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sign_in()),
                    );
                  },
                  child: Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
