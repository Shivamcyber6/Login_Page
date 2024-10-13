import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/login_view_model.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel viewModel = LoginViewModel();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: viewModel.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: viewModel.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await viewModel.login(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
