// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
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

  final List<String> _countries = ['Russia', 'Ukraine', 'German', 'France'];
  String? _selectedCountry;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Form'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
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

  Widget fullName() {
    return TextFormField(
      validator: _validateName,
      controller: _nameController,
      decoration: InputDecoration(
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
      validator: (value) => _validatePhoneNumber(value!)
          ? null
          : 'Phone number must be entered as (###)###-####',
      controller: _phoneController,
      inputFormatters: [
        FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'), allow: true),
      ],
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(labelText: 'phone number*'),
    );
  }

  Widget emailAdress() {
    return TextFormField(
      validator: _validateEmail,
      controller: _emailController,
      decoration: const InputDecoration(labelText: 'email adress*'),
    );
  }

  Widget dropDownCountry() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.map),
          labelText: 'select country*',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
      items: _countries.map((country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (country) {
        print(country);
        setState(() {
          _selectedCountry = country;
        });
      },
      value: _selectedCountry,
      validator: ((value) {
        return value == null ? 'Please select country' : null;
      }),
    );
  }

  Widget lifeStory() {
    return TextFormField(
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
      print('form is valid');
      print('name: ${_nameController.text}');
      print('phone: ${_phoneController.text}');
      print('email: ${_emailController.text}');
      print('lifeStory: ${_lifeStoryController.text}');
      print('country: $_selectedCountry');
    } else {
      print('Ошибка');
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
    if (value!.isEmpty) {
      return 'обязательное поле';
    } else if (!_emailController.text.contains('@')) {
      return 'а где собака?';
    } else {
      return null;
    }
  }

  String? _validatePass(value) {
    if (_passwordController.text.length < 8) {
      return 'длина пароля должна быть не меньше 8';
    } else if (value == null) {
      return "обязательное поле";
    } else if (_passwordController.text != _confirmPasswordController.text) {
      return 'пароли не совпадают';
    } else {
      return null;
    }
  }
}
