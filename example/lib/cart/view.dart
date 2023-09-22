import 'package:example/cart/commponent/mobile.dart';
import 'package:example/cart/commponent/webv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Example1 extends StatefulWidget {
  const Example1({super.key});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Example 1")),
        body: kIsWeb ? const WebV() : const MobileComponent());
  }
}
