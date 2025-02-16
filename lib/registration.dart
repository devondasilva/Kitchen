import 'package:flutter/material.dart';
import 'database_helper.dart'; // Import your database helper


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final dbHelper = DatabaseHelper.instance;
      final newUser = {
        'username': _usernameController.text,
        'password': _passwordController.text,
        'email': _emailController.text,
      };

      try {
        // Check if username or email already exists
        final existingUser = await dbHelper.getUser(_usernameController.text);
        if (existingUser.isNotEmpty) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Username already exists.';
          });
          return; // Stop registration
        }

        // Insert the new user
        await dbHelper.insertUser(newUser);

        // Navigate to login page after successful registration
        Navigator.pushNamed(context, '/login'); // Or use Navigator.pushReplacement
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginPage()),
        // );

      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error during registration: $error';
        });
        print('Registration Error: $error'); // Print for debugging
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: SingleChildScrollView( // For scrollable form
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress, // For email input
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    // You can add more email validation here if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) { // Example password length validation
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}