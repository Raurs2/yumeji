import 'package:app_kanji/widgets/login/my_button.dart';
import 'package:app_kanji/widgets/login/square_tile.dart';
import 'package:app_kanji/widgets/login/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth_services.dart';

class Register extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final void Function()? onTap;

  Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  List<bool> boolean = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  //sign user up
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //try sign up
    try {
      //chech password
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //int x = 0;
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('users');
        final id = FirebaseAuth.instance.currentUser!.uid;
        final docUser = FirebaseFirestore.instance.collection('users').doc(id);
        await docUser.set({
          'uid': id,
          "email": emailController.text,
          "username": usernameController.text,
          "coins": 50,
          'cards': 0,
          'cards_pack': 1,
          'storeItems': boolean,
        });
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        //show error passwoord dont match
        wrongDialog("Senhas não são iguais!");
      }
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error message
      wrongDialog(e.code);
    }
  }

  // popup wrong
  void wrongDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: const Color.fromARGB(100, 100, 100, 100),
              title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo
                Image.asset(
                  'assets/logos/app-icon.png',
                  height: 200,
                ),

                const SizedBox(height: 50),

                //welcome message
                const Text(
                  'Yumeji',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),

                const SizedBox(height: 25),

                //username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Usuário',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //password confirm textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //Sign in
                MyButton(
                  text: 'Cadastrar',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 20),

                //logar com divisor
               /* const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Ou cadastre-se com'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //sign in google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      SquareTile(
                        imagePath: "assets/logos/google-logo.webp",
                        onTap: () => AuthService().signInWithGoogle(),
                      ),
                    ],
                  ),
                ),*/

                //const SizedBox(height: 25),

                //sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('já tem conta?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'logar-se',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
