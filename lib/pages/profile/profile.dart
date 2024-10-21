import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/variables.dart';
import '../../widgets/login/my_divider.dart';
import '../../widgets/login/my_text.dart';
import '../../widgets/profile_picture_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //sign out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 71, 59),
          title: const Text(
            "横顔 Perfil",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
          ],
        ),
        body: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore
                .instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!
                .uid) // 👈 Your document id which is equal to currentuser
                .snapshots(),
            builder:
                (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Icon(Icons.error);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              Map<String, dynamic> data =
              snapshot.data!.data()! as Map<String, dynamic>;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),



                        //profile pic
                        Center(
                          child: ProfilePictureImage(image: profilePicture, x: 200, y: 200,)
                        ),
                        const SizedBox(height: 20),

                        const MyDivider(),
                        const SizedBox(height: 50),

                        MyText(text: 'Usuário: ${data["username"]}'),
                        const SizedBox(height: 10),

                        MyText(text: 'Email: ${data["email"]}'),
                        const SizedBox(height: 20),

                        const MyDivider(),
                        const SizedBox(height: 50),

                        MyText(text: 'Moedas: ${data["coins"]}'),
                        const SizedBox(height: 10),
                        MyText(text: 'Cartas estudadas: ${data["cards"]}'),
                        const SizedBox(height: 20),
                        const MyDivider(),

                        Wrap(
                          children: [
                            const MyText(text: 'Conquistas: '),
                            data["coins"] >= 10 ? const MyText(text: '「小銭」') : const SizedBox(),
                            data["coins"] > 50 ? const MyText(text: '「会社員」') : const SizedBox(),
                            data["coins"] > 100 ? const MyText(text: '「お金持ち」') : const SizedBox(),
                            data["cards"] >= 1 ? const MyText(text: '「初札」') : const SizedBox(),
                            data["cards"] > 10 ? const MyText(text: '「勉強好き」') : const SizedBox(),
                            data["cards"] >= 20 ? const MyText(text: '「学者」') : const SizedBox(),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }


}