import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

class MobileComponent extends StatelessWidget {
  const MobileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Checkbox(value: false, onChanged: (val) {}),
            horizontalTitleGap: 8,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding: EdgeInsets.zero,
            title: const Text("Lorem Ipsum"),
            subtitle: const Text("Location and others"),
          ),
          Row(
            children: [
              Checkbox(value: false, onChanged: (val) {}),
              Expanded(
                flex: 3,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 100, minHeight: 50),
                  child: Image.network(
                    'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Placeholder(),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Category",
                        style: TextStyle(color: Colors.black38),
                        textScaler: TextScaler.linear(0.88),
                      ),
                      SizedBox(height: 2),
                      Text("Price")
                    ],
                  ))
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text("Tulis catatan")),
              const InputQty(),
            ],
          ),
          // const SizedBox(height: 20)
        ],
      ),
    );
  }
}
