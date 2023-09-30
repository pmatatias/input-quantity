import 'package:example/cart/view.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
// import 'package:input_quantity/input_quantity.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Quantity Example',
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

  int qtyInt = 123;
  double qtyDouble = 12.0;
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputQty(
                      maxVal: 50,
                      initVal: 10,
                      steps: 10,
                      minVal: -50,
                      qtyFormProps: QtyFormProps(enableTyping: false),
                      decoration: QtyDecorationProps(
                        isBordered: false,
                        minusBtn: Icon(
                          Icons.flight_land_rounded,
                          color: Colors.purple,
                        ),
                        plusBtn:
                            Icon(Icons.flight_takeoff, color: Colors.indigo),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Text(
                          "- Output: int,double, num\n- initVal, maxVal, minVal, steps \n- Custom: icon,decoration,etc"),
                    )
                  ],
                ),
                const Divider(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputQty(
                        decoration: QtyDecorationProps(
                            isBordered: false,
                            borderShape: BorderShapeBtn.circle,
                            width: 12)),
                    SizedBox(width: 30),
                    Expanded(
                        child: Text(
                            "- Ontap\n- Longpress \n- Typing input Manually"))
                  ],
                ),
                const Divider(height: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Use validator')),
                        InputQty(
                          initVal: 0,
                          steps: 10,
                          minVal: -100,
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else if (value >= 100) {
                              return "More than available quantity";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const Center(
                        child: Text(
                      "OR",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Message builder',
                            )),
                        InputQty(
                          initVal: 0,
                          minVal: -100,
                          maxVal: 100,
                          steps: 2,
                          messageBuilder: (minVal, maxVal, value) {
                            if (value == null) return null;
                            if (value < -20) {
                              return const Text(
                                "Reach my limit",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else if (value > 20) {
                              return const Text(
                                "Reach my limit",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Text("Value : $value",
                                  textAlign: TextAlign.center);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 50),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('integer')),
                        InputQty.int(
                          initVal: 0,
                          steps: 10,
                          minVal: -100,
                        ),
                      ],
                    ),
                    Center(
                        child: Text(
                      "OR",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'double',
                            )),
                        InputQty(
                          initVal: 0.0,
                          minVal: -100.0,
                          maxVal: 100.0,
                          steps: 2.5,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 30),

                // ElevatedButton(
                //     onPressed: () {
                //       _formKey.currentState!.validate();
                //     },
                //     child: const Text("validate")),
                // const Divider(),

                const Text("Style options:"),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Left",
                          textAlign: TextAlign.center),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnLeft,
                          width: 12,
                          fillColor: Colors.black12,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Right",
                          textAlign: TextAlign.center),
                      qtyFormProps:
                          const QtyFormProps(cursorColor: Colors.amber),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnRight,
                          width: 12,
                          fillColor: Colors.black12,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                InputQty.int(
                  messageBuilder: (minVal, maxVal, value) =>
                      const Text("Classic", textAlign: TextAlign.center),
                  decoration: const QtyDecorationProps(
                      qtyStyle: QtyStyle.classic,
                      width: 12,
                      fillColor: Colors.black12,
                      isBordered: false,
                      borderShape: BorderShapeBtn.none),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Right Horizontal",
                          textAlign: TextAlign.center),
                      qtyFormProps:
                          const QtyFormProps(cursorColor: Colors.amber),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnLeft,
                          width: 12,
                          orientation: ButtonOrientation.horizontal,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Right Horizontal",
                          textAlign: TextAlign.center),
                      qtyFormProps:
                          const QtyFormProps(cursorColor: Colors.amber),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnRight,
                          width: 12,
                          orientation: ButtonOrientation.horizontal,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                  ],
                ),

                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Example1(),
                        )),
                    icon: const Icon(Icons.exit_to_app))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
