// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yo_app/models/user.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _hidePass1 = true;
  bool _hidePass2 = true;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _lifeStoryController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmPassFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _lifeStoryController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    _confirmPassFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final List<String> _countries = ['Russia', 'Leningrad', 'German', 'France'];
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.teal.shade300),
            borderRadius: BorderRadius.circular(15)),
        title: const Text('Register Form'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              fullName(),
              const SizedBox(height: 10),
              phoneNumber(),
              const SizedBox(height: 10),
              emailAdress(),
              const SizedBox(height: 10),
              dropDownCountry(),
              const SizedBox(height: 20),
              lifeStory(),
              const SizedBox(height: 10),
              password(),
              const SizedBox(height: 10),
              confirmPassword(),
              const SizedBox(height: 15),
              submitButton(),
            ],
          )),
    );
  }

  // Widget icon1() {
  //   return Icon(Icons.delete);
  // }

  // Widget icon2() {
  //   return Icon(Icons.delete_forever);
  // }

  // Widget changeIcon() {
  //   _nameController.dispose;
  //   return IconButton(
  //       onPressed: () {},
  //       icon: GestureDetector(
  //         child: icon1(),
  //         onTap: () {
  //           setState(() {
  //             _nameController.text.isEmpty ? icon2() : icon1();
  //           });
  //           _nameController.clear();
  //         },
  //       ));
  // }

  Widget fullName() {
    return TextFormField(
      focusNode: _nameFocus,
      autofocus: true,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _nameFocus, _phoneFocus);
      },
      onSaved: (value) => newUser.name = value!,
      validator: _validateName,
      controller: _nameController,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          child: const Icon(Icons.delete_outline),
          onTap: () {
            _nameController.clear();
          },
        ),
        hintText: 'введите свое имя',
        labelText: ' full name',
        prefixIcon: const Icon(Icons.apple),
        suffix: const Icon(Icons.delete, color: Colors.red, size: 2),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.teal, width: 4),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: Colors.teal.shade300, width: 3)),
      ),
      inputFormatters: [],
    );
  }

  Widget phoneNumber() {
    return TextFormField(
      onSaved: (value) => newUser.phone = value!,
      focusNode: _phoneFocus,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _phoneFocus, _passFocus);
      },
      validator: (value) => _validatePhoneNumber(value!)
          ? null
          : 'Phone number must be entered as (###)###-####',
      controller: _phoneController,
      inputFormatters: [
        FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'), allow: true),
      ],
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'phone number*',
        suffixIcon: GestureDetector(
          child: const Icon(Icons.delete_outline),
          onTap: () {
            _nameController.clear();
          },
        ),
      ),
    );
  }

  Widget emailAdress() {
    return TextFormField(
      onSaved: (value) => newUser.email = value!,
      validator: _validateEmail,
      controller: _emailController,
      decoration: const InputDecoration(labelText: 'email adress'),
    );
  }

  Widget dropDownCountry() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.map),
          labelText: 'select country',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
      items: _countries.map((country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (data) {
        print(data);
        setState(() {
          newUser.country = data!;
          _selectedCountry = data;
        });
      },
      value: _selectedCountry,
      // validator: ((value) {
      //   return value == null ? null : null;
      // }),
    );
  }

  Widget lifeStory() {
    return TextFormField(
      onSaved: (value) => newUser.story = value!,
      controller: _lifeStoryController,
      decoration: const InputDecoration(labelText: 'life story'),
      maxLines: 3,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
    );
  }

  Widget password() {
    return TextFormField(
      focusNode: _passFocus,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _passFocus, _confirmPassFocus);
      },
      validator: _validatePass,
      controller: _passwordController,
      maxLength: 12,
      decoration: InputDecoration(
          labelText: 'password*',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _hidePass1 = !_hidePass1;
                });
              },
              icon: _hidePass1
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility))),
      obscureText: _hidePass1,
    );
  }

  Widget confirmPassword() {
    return TextFormField(
      focusNode: _confirmPassFocus,
      controller: _confirmPasswordController,
      maxLength: 12,
      decoration: InputDecoration(
          labelText: 'confirm password',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _hidePass2 = !_hidePass2;
                });
              },
              icon: _hidePass2
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility))),
      obscureText: _hidePass2,
      validator: _validatePass,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
      child: const Text('send information'),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: '${_nameController.text} succesful registered');
      log('name: ${_nameController.text}');
      log('phone: ${_phoneController.text}');
      log('email: ${_emailController.text}');
      log('lifeStory: ${_lifeStoryController.text}');
      log('country: $_selectedCountry');
    } else {
      _showMessage(message: 'Form is not valid! Please recheck');
    }
  }

  String? _validateName(String? value) {
    final nameExp = RegExp(r'^[A-Z a-z]+$');
    if (value!.isEmpty) {
      return 'это обязательное поле';
    } else if (!nameExp.hasMatch(value)) {
      return 'Пишите буквы але';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return phoneExp.hasMatch(input);
  }

  String? _validateEmail(String? value) {
    // final emailExp = RegExp(r'/^[^\s@]+@[^\s@]+\.[^\s@]+$/');
    if (value!.isEmpty) {
      return null;
      // } else if (!emailExp.hasMatch(value)) {
      //   return 'error';
    } else if (!_emailController.text.contains('@')) {
      return 'а где собака?';
    } else {
      return null;
    }
  }

  String? _validatePass(value) {
    if (value!.isEmpty) {
      return null;
    } else if (_passwordController.text.length < 8) {
      return 'длина пароля должна быть не меньше 8';
    } else if (_passwordController.text != _confirmPasswordController.text) {
      return 'пароли не совпадают';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.teal.shade400, width: 10),
            borderRadius: BorderRadius.circular(36)),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.teal,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )));
  }

  void _showDialog({required String name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.access_time_sharp),
            title: const Text(
              'Registration succesful',
              style: TextStyle(color: Colors.green),
            ),
            content: Text(name),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/user',
                      ((route) => false),
                      arguments: newUser,
                    );
                  },
                  child: const Text(
                    'отлично',
                    style: TextStyle(color: Colors.green),
                  ))
            ],
          );
        });
  }
}
