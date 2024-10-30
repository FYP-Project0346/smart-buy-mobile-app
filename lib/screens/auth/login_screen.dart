import 'package:flutter/material.dart';
import 'package:smartbuy/generate_route.dart';
import 'package:smartbuy/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isPasswordShown = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textFieldWidth = screenWidth / 1.25;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  RouteGenerator.generateRoute(
                      context, RouteSettings(name: Routes.register)));
            },
            child: const Text(
              "Register",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Text Field
              SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email Address",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Text Field
              SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: passwordController,
                  obscureText: !isPasswordShown,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Enter Password",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordShown ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordShown = !isPasswordShown;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: textFieldWidth,
                child: ElevatedButton(
                  onPressed: isLoading ? null : loginActionHandler,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text("Login", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginActionHandler() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    setState(() {
      isLoading = true;
    });
    try {
      if (email.isEmpty) {
        throw Exception("Please enter your email address.");
      }
      if (password.isEmpty) {
        throw Exception("Please enter your password.");
      }

      var status = await AuthService().login(email, password);
      if (status) {
        Navigator.pushAndRemoveUntil(
          context,
          RouteGenerator.generateRoute(context, RouteSettings(name: Routes.home)),
              (route) => false,
        );
      } else {
        throw Exception("Could not log in. Please check your credentials.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll("Exception: ", "")),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
