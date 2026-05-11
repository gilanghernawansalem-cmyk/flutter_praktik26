import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Controller untuk mengambil input user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Key untuk validasi form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Fungsi login
  void _login() {

    // Validasi form
    if (_formKey.currentState!.validate()) {

      // Ambil nilai input
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      // Tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil dengan email: $email'),
        ),
      );

      // Debug console
      debugPrint("Email: $email");
      debugPrint("Password: $password");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Input Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }

                  // Validasi format email
                  if (!value.contains('@')) {
                    return 'Format email tidak valid';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Input Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }

                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Tombol Login
              SizedBox(
                height: 50,

                child: ElevatedButton(
                  onPressed: _login,

                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Tombol ke halaman register
              TextButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },

                child: const Text(
                  'Belum punya akun? Daftar di sini',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}