import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image.asset('assets/logos/app-icon.png', fit: BoxFit.scaleDown),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 10, 0, 97),
        title: const Text(
          "遊 Jogos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 500,
                height: 200,
                child: CupertinoButton(
                  color: const Color.fromARGB(255, 10, 0, 97),
                  borderRadius: BorderRadius.circular(40),
                  child: const Text(
                    "暗記\nMemorando",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 45,
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/game1'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 500,
                height: 200,
                child: CupertinoButton(
                  color: const Color.fromARGB(255, 10, 0, 97),
                  borderRadius: BorderRadius.circular(40),
                  child: const Text(
                    "綴り\nSoletrando",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 45,
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/game2'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
