import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
// import 'package:input_quantity/input_quantity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inout Quantity Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Input Quantity'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  int abf = 123;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'INPUT QUANTITY',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'by: pmatatias.dev',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                const Divider(),
                const InputQty.int(
                  maxVal: 70,
                  decoration: QtyDecorationProps(
                      qtyStyle: QtyStyle.btnOnLeft,
                      width: 12,
                      // fillColor: Colors.amber,
                      isBordered: true,
                      borderShape: BorderShapeBtn.none),
                ),
                const Divider(),
                const InputQty.double(
                  decoration: QtyDecorationProps(
                      width: 12,
                      borderShape: BorderShapeBtn.square,
                      qtyStyle: QtyStyle.btnOnRight),
                ),
                const Divider(),
                const InputQty(
                    decoration: QtyDecorationProps(isBordered: false)),
                const Divider(),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Easy and solid')),
                InputQty(
                  maxVal: 5,
                  initVal: 0,
                  steps: 1,
                  minVal: -5,
                  borderShape: BorderShapeBtn.square,
                  boxDecoration: const BoxDecoration(),
                  messageBuilder: (maxVal, minVal, value) {
                    return Text("$maxVal, $minVal, $value");
                  },
                  decoration: const QtyDecorationProps(
                    isBordered: false,
                    minusBtn: Icon(
                      Icons.accessibility_new_outlined,
                      size: 22,
                      color: Colors.amber,
                    ),
                    plusBtn: Icon(Icons.accessible_forward, size: 22),
                  ),
                ),
                const Divider(),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('With steps : 10 (customizable)')),
                const InputQty(
                    maxVal: 100, initVal: 0.0, steps: 10, minVal: -100),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Min,max and initial value. Change color'),
                ),
                InputQty(
                  maxVal: 50,
                  initVal: 12,
                  minVal: -50,
                  steps: 10,
                  borderShape: BorderShapeBtn.none,
                  decoration: const QtyDecorationProps(
                    isBordered: false,
                    width: 12,
                    plusBtn: Icon(Icons.add_box),
                    minusBtn: Icon(Icons.indeterminate_check_box),
                  ),
                  btnColor1: Colors.teal,
                  btnColor2: Colors.red,
                  onQtyChanged: (val) {
                    if (kDebugMode) {
                      print("UI : $val ");
                    }
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Intrinsic width ( default )'),
                ),
                InputQty(
                  maxVal: 100,
                  initVal: 0,
                  onQtyChanged: (val) {
                    if (kDebugMode) {
                      print("UI : $val ");
                    }
                  },
                ),
                const Divider(),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Expanded width')),
                InputQty(
                  maxVal: 100,
                  initVal: 0,
                  isIntrinsicWidth: false,
                  onQtyChanged: (val) {
                    if (kDebugMode) {
                      print("UI : $val ");
                    }
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Customize input size'),
                ),
                InputQty(
                  maxVal: 100.0,
                  initVal: 0.0,
                  textFieldDecoration: const InputDecoration(
                      isDense: false,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  minVal: -100.0,
                  onQtyChanged: (val) {
                    if (kDebugMode) {
                      print("UI : $val ");
                    }
                  },
                ),
                const Divider(),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                    },
                    child: const Text("validate")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
