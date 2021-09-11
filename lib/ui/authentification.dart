import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';
import 'package:simple_task_manager_firebase/ui/home_page.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('simple task manager'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: Column(
            children: [
              TextFormField(
                controller: _loginController,
                decoration: InputDecoration(
                    hintText: 'email@email.com',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '********',
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              Container(
                child: TextButton(
                  child: Text('Register'),
                  onPressed: () async {
                    bool moveNext = await register(
                        _loginController.text, _passwordController.text);
                    if (moveNext) {
                      // move to another menu
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                ),
              ),
              Container(
                child: TextButton(
                  child: Text('Login'),
                  onPressed: () async {
                    bool moveNext = await signIn(
                        _loginController.text, _passwordController.text);
                    if (moveNext) {
                      // move to another menu
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
