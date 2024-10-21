import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/variables.dart';
import '../../utils/player.dart';
import '../../widgets/profile_picture_image.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  int user_coins = 0;
  final int profile_price = 50;
  late List<bool> isBought;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            'Moedas: $user_coins',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image.asset('assets/logos/app-icon.png', fit: BoxFit.scaleDown),
          ),
        ],
        title: const Text(
          "店 Loja",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 97, 0, 0),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!
                  .uid) // 👈 Your document id which is equal to currentuser
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Icon(Icons.error);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            Map<String, dynamic> data =
                snapshot.data!.data()! as Map<String, dynamic>;
            //notifier.changeCardPack(number: data['cards_pack'].toString());
            user_coins = data['coins'];
            isBought = List.from(snapshot.data?['storeItems']);
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildRow(item: profile1, number: 0),
                      buildRow(item: profile2, number: 1),
                      buildRow(item: profile3, number: 2),
                      buildRow(item: profile4, number: 3),
                      buildRow(item: profile5, number: 4),
                      buildRow(item: profile6, number: 5),
                      buildRow(item: profile7, number: 6),
                      buildRow(item: profile8, number: 7),
                      buildRow(item: profile9, number: 8),
                      buildRow(item: profile10, number: 9),
                      buildRow(item: profile11, number: 10),
                      buildRow(item: profile12, number: 11),
                      buildRow(item: profile13, number: 12),
                      buildRow(item: profile14, number: 13),
                      buildRow(item: profile15, number: 14),
                      buildRow(item: profile16, number: 15),
                      buildRow(item: profile17, number: 16),
                      buildRow(item: profile18, number: 17),
                      buildRow(item: profile19, number: 18),
                      buildRow(item: profile20, number: 19),
                      buildRow(item: profile21, number: 20),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Row buildRow({required String item, required int number}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildStoreItems(item: item, number: number),
      Center(
        child: !isBought[number]
            ? Text(
                '\n$profile_price',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            : const Text(
                '\nComprado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
      )
    ]);
  }

  GestureDetector buildStoreItems({required String item, required int number}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          final DocumentReference docRef = FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid);
          if (isBought[number]) {
            Player.play('audios/correct.mp3');
            profilePicture = item;
            docRef.update({"coins": FieldValue.increment(-profile_price)});
            docRef.update({"coins": FieldValue.increment(profile_price)});
          } else if (user_coins >= profile_price && !isBought[number]) {
            Player.play('audios/buy.mp3');
            profilePicture = item;
            isBought[number] = true;
            user_coins -= profile_price;
            docRef.update({
              "coins": FieldValue.increment(-profile_price),
              'storeItems': isBought,
            });
          }
        });
      },
      child: Container(
        //alignment: Alignment.topRight,

        padding: const EdgeInsets.symmetric(vertical: 10),
        //margin: const EdgeInsets.symmetric(horizontal: 25),
        //decoration: BoxDecoration(
        //color: const Color.fromARGB(255, 58, 0, 81),
        //borderRadius: BorderRadius.circular(10),
        //),
        child: ProfilePictureImage(
          image: item,
          x: 150,
          y: 150,
        ),
      ),
    );
  }
}
