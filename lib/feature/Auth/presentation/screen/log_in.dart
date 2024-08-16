import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:curt_task/core/utililes/app_strings.dart';
import 'package:curt_task/core/utililes/font_styles.dart';
import 'package:curt_task/feature/Auth/presentation/controller/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    Text(AppStrings.loginToYourAccount,
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
                            SnackBar(content: Text(state.error)),
                          );
                        } else if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(AppStrings.loginSuccessful)),
                          );
                          Navigator.pushReplacementNamed(context, '/inventory');
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          width: 90,
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
                              context.read<AuthCubit>().login(email, password);
                            },
                            child: Text(
                              AppStrings.login,
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
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {},
                child: const Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(color: darkPurple),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppStrings.signUpRoute);
                    },
                    child: const Text(
                      AppStrings.signUp,
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