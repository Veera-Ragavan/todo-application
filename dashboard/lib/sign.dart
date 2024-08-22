import 'package:dashboard/register.dart';
import 'package:flutter/material.dart';

class Sign_in extends StatelessWidget {
  Sign_in({super.key});

  final TextEditingController user_nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobile_noController = TextEditingController();

  get http => null;

  Future<void> register() async {
    Uri url = Uri.parse('http://192.168.155.170:9876/user');

    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      var json;
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
          title: Center(child: Text('')), backgroundColor: Colors.yellow),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://www.reviewstudio.com/wp-content/uploads/2021/04/Header-image-optimize-to-do-list-scaled.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 400,
            width: 400,
            child: Column(children: <Widget>[
              Title(
                color: Colors.black,
                child: Text(
                  'Sign up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10, width: 30),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(
                height: 10,
                width: 30,
              ),
              TextField(
                controller: passwordController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Enter your password'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              Row(mainAxisSize: MainAxisSize.max, children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
