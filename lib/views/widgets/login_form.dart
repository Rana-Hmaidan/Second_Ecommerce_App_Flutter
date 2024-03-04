import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/auth_cubit/auth_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/social_item.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/forgot_password_modal_bottomsheet.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isVisible = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      debugPrint('Email: ${_emailController.text}');
      debugPrint('Password: ${_passwordController.text}');
      await BlocProvider.of<AuthCubit>(context).signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  String? validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Password must contain at least 8 characters, including uppercase, lowercase, number, and special character';
    }
  }

  String? validateEmail(String value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration:  InputDecoration(
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email),
              prefixIconColor: _emailController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
            ),
            validator: (value) => validateEmail(value!),
          ),
          const SizedBox(height: 24),
          Text(
            'Password',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.password),
              prefixIconColor: _passwordController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                icon: Icon(_isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
              ),
            ),
            obscureText: !_isVisible,
            // validator: (value) => validatePassword(value!),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () => showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context, 
                  builder: (ctx) => ForgotPasswordModalBottomsheet(userEmail: _emailController.text),
                ),
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ),
          ),
          const SizedBox(height: 36),
          BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listenWhen: (previous, current) =>
                current is AuthSuccess || current is AuthFailure,
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushNamed(context, AppRoutes.bottomNavbar);
              } else if (state is AuthFailure) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(state.message),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              }
            },
            buildWhen: (previous, current) =>
                current is AuthLoading ||
                current is AuthFailure ||
                current is AuthSuccess,
            builder: (context, state) {
              if (state is AuthLoading) {
                return const MainButton(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return MainButton(
                onPressed: login,
                title: 'Login',
              );
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text(
              'or, using other method',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16.0,),
                      SocialItem(
                        icon: FontAwesomeIcons.google,
                        title: 'Login with Google',
                        color: AppColors.red,
                        onTap: (){},
                      ),
                      const SizedBox(height: 16.0,),
                      SocialItem(
                        icon: FontAwesomeIcons.facebookF,
                        title: 'Login with Facebook',
                        color: AppColors.blue,
                        onTap: (){},
                      ),
                      const SizedBox(height: 16.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed(AppRoutes.createAccount);
                            }, 
                            child: Text(
                              'Create Account',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
        ],
      ),
    );
  }
}