import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:curt_task/core/utililes/app_strings.dart';
import 'package:curt_task/core/utililes/font_styles.dart';
import 'package:curt_task/feature/Auth/presentation/controller/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    FontStyles.init();
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 35.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppStrings.signUpImage,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(AppStrings.createYourAccount,
                        style: FontStyles.loginHeader),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.email,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: darkPurple),
                          borderRadius: BorderRadius.zero,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: darkPurple),
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: AppStrings.password,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: darkPurple),
                          borderRadius: BorderRadius.zero,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: darkPurple),
                          borderRadius: BorderRadius.zero,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: darkPurple,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sign up failed")),
                          );
                        } else if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(AppStrings.signUpSuccessful)),
                          );
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkPurple,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              final email = emailController.text;
                              final password = passwordController.text;
                              context.read<AuthCubit>().signUp(email, password);
                            },
                            child: Text(
                              AppStrings.signUp,
                              style: FontStyles.login,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.haveAnAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppStrings.loginRoute);
                    },
                    child: const Text(
                      AppStrings.login,
                      style: TextStyle(color: darkPurple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 