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
          title: Center(child: Text('SIGN IN PAGE')),
          backgroundColor: Colors.yellow),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Center(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: 'username',
                    hintText: 'enter mail id',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.amber),
                  decoration: InputDecoration(
                      labelText: 'password', hintText: 'enter your password'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text('Login'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
