import 'package:csc_picker/csc_picker.dart';
import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/logic/cubits/cubit/login_cubit.dart';
import 'package:event_hub/presentation/screens/auth/login.dart';
import 'package:event_hub/presentation/screens/home/home.dart';
import 'package:event_hub/widgets/button.dart';
import 'package:event_hub/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/toast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  @override
  Widget build(BuildContext context) {
    final ToastMessage toastMessage = ToastMessage();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
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
          if (state is LoginSuccessState) {
            return const Home();
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('Sign up',
                          style: TextStyle(
                            color: Color(0xFF37364A),
                            fontSize: 25,
                            fontFamily: 'Airbnb Cereal App',
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    controller: _usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    prefixIcon: Image.asset('assets/images/profile.png'),
                  ),
                  TextInput(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                    prefixIcon: Image.asset('assets/images/mail.png'),
                  ),
                  TextInput(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Image.asset('assets/images/lock.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: CSCPicker(
                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                      showStates: true,

                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                      showCities: true,

                      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade500, width: 1)),

                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade500, width: 1)),

                      ///placeholders for dropdown search field
                      countrySearchPlaceholder: 'Country',
                      stateSearchPlaceholder: 'State',
                      citySearchPlaceholder: 'City',

                      ///labels for dropdown
                      countryDropdownLabel: 'Country',
                      stateDropdownLabel: 'State',
                      cityDropdownLabel: 'City',

                      ///Default Country
                      //defaultCountry: CscCountry.India,

                      ///Disable country dropdown (Note: use it with default country)
                      //disableCountry: true,

                      ///selected item style [OPTIONAL PARAMETER]
                      selectedItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                      dropdownHeadingStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                      dropdownItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///Dialog box radius [OPTIONAL PARAMETER]
                      dropdownDialogRadius: 10.0,

                      ///Search bar radius [OPTIONAL PARAMETER]
                      searchBarRadius: 10.0,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          countryValue = value ?? "";
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          ///store value in state variable
                          stateValue = value ?? "";
                        });
                      },

                      ///triggers once city selected in dropdown
                      onCityChanged: (value) {
                        setState(() {
                          ///store value in city variable
                          cityValue = value ?? "";
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _usernameController.text.isEmpty) {
                        toastMessage.failedToast('Please fill all fields');
                      } else {
                        BlocProvider.of<LoginCubit>(context).SignupUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _usernameController.text,
                            country: countryValue,
                            state: stateValue,
                            city: cityValue);
                      }
                    },
                    backgroundColor: AppColors().primary,
                    foregroundColor: Colors.white,
                    title: 'Sign up',
                    isLoading: state is LoginLoadingState ? true : false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Text('Signin',
                            style: TextStyle(
                                fontSize: 17, color: AppColors().primary)),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
