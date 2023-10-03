import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/presentation/screens/home/home.dart';
import 'package:event_hub/presentation/screens/auth/signup.dart';
import 'package:event_hub/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/cubit/login_cubit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ToastMessage toastMessage = ToastMessage();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocConsumer(
            bloc: BlocProvider.of<LoginCubit>(context),
            listener: (context, state) {
              if (state is LoginFailedState) {
                toastMessage.failedToast(state.message);
              }
              if (state is LoginSuccessState) {
                toastMessage.successToast(state.message);
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                });
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Event Hub',
                      style: TextStyle(
                        color: Color(0xFF37364A),
                        fontSize: 35,
                        fontFamily: 'Airbnb Cereal App',
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('Sign in',
                          style: TextStyle(
                            color: Color(0xFF37364A),
                            fontSize: 25,
                            fontFamily: 'Airbnb Cereal App',
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFE4DEDE),
                            width: 0.5,
                          ),
                        ),
                        prefixIcon: Image.asset('assets/images/mail.png'),
                        hintText: 'abc@gmail.com',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Airbnb Cereal App',
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFE4DEDE),
                            width: 0.5,
                          ),
                        ),
                        prefixIcon: Image.asset('assets/images/lock.png'),
                        hintText: 'your password',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Airbnb Cereal App',
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.black),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginCubit>(context).LoginUser(
                          email: emailController.text,
                          password: passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().primary,
                        foregroundColor: Colors.white,
                        fixedSize: Size(size.width * 0.75, 65),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: state is LoginLoadingState
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'SIGN IN',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()));
                        },
                        child: Text('Sign up',
                            style: TextStyle(
                                fontSize: 17, color: AppColors().primary)),
                      ),
                    ],
                  )
                ],
              ));
            }));
  }
}
