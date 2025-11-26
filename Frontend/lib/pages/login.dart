import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/components/signin_login/auth_field.dart';
import 'package:jklu_eezy/components/signin_login/auth_gradient.dart';
import 'package:jklu_eezy/pages/home.dart';
import 'package:jklu_eezy/pages/signup.dart';
import 'package:jklu_eezy/components/signin_login/app_pallete.dart';
import '../components/storage.dart';




class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      String baseUrl;
      // if (Platform.isAndroid) {
      //   baseUrl = Platform.isAndroid ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}"; // Android emulator localhost
      // } else {
      //   baseUrl = Platform.isIOS ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}";
      // }

      baseUrl = "${dotenv.env['BACKEND_URL']}";

      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text.trim(),
          'password': passwordController.text,
        }),
      );

      final data = json.decode(response.body);


      if (response.statusCode == 200) {
        final token = data['token'];
        await saveToken(token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home(
          )),
        );
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Connection error. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              AuthField(
                hintText: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              GestureDetector(
                onTap: isLoading ? null : login,
                child: AuthGradientButton(
                  buttonText: isLoading ? 'Signing In...' : 'Sign In',
                  onPressed: isLoading ? () {Home();} : login,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to Sign Up page
                  Navigator.push(
                    context,
                    SignUpPage.route(),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
              ),
          ],
                ),
        ),
    ),

      
    );
  }
}
