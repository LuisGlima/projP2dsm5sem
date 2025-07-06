import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'tela_home.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await dbHelper.getUser(_emailController.text, _passController.text);
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaHome()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login inválido')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent, // Pokedex red
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0), // Red border on focus
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.redAccent),
                  ),
                  validator: (value) => value!.contains('@') ? null : "Email inválido",
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                  ),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? "Senha obrigatória" : null,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Pokedex red button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
