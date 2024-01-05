import 'package:chatgpt_test/component/box.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(),
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('Elevated Button')),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.calendar_month)),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            boxWidget(context),
          ],
        ),
      ),
    );
  }
}
