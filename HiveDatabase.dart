import 'package:flutter/material.dart';
import 'package:flutter_api/Hive%20Database/Button.dart';
import 'package:flutter_api/Hive%20Database/HiveDatabase_Model.dart';
import 'package:hive_flutter/adapters.dart';
// ignore: duplicate_import
import 'Button.dart'; // Import your custom Button widget

class HiveDatabase_2 extends StatefulWidget {
  const HiveDatabase_2({super.key});

  @override
  State<HiveDatabase_2> createState() => _HiveDatabase_2State();
}

class _HiveDatabase_2State extends State<HiveDatabase_2> {
  final Box<HiveDataModel> hiveBox = Hive.box<HiveDataModel>('hiveBox');

  void _showDialog({HiveDataModel? data, int? index}) {
    final TextEditingController nameController = TextEditingController(
      text: data?.name ?? "",
    );
    final TextEditingController priceController = TextEditingController(
      text: data?.price.toString() ?? "",
    );
    final TextEditingController centsController = TextEditingController(
      text: data?.cents.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            data == null ? 'Add Data' : 'Edit Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Enter name"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter price",
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing between the fields
                  Expanded(
                    child: TextField(
                      controller: centsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter cents",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Button(
              height: 40,
              width: 100,
              title: 'Cancel',
              onTap: () => Navigator.pop(context),
              isLoading: false,
              color: Colors.teal,
            ),
            Button(
              height: 40,
              width: 100,
              title: 'Save',
              onTap: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    centsController.text.isNotEmpty) {
                  final newData = HiveDataModel(
                    name: nameController.text,
                    price: int.tryParse(priceController.text) ?? 0,
                    cents: int.tryParse(centsController.text) ?? 0,
                  );

                  if (data == null) {
                    hiveBox.add(newData);
                  } else {
                    hiveBox.putAt(index!, newData);
                  }

                  Navigator.pop(context);
                  setState(() {});
                }
              },
              isLoading: false,
              color: Colors.teal,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Database 2'),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<HiveDataModel>>(
        valueListenable: hiveBox.listenable(),
        builder: (context, box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final data = box.getAt(index);
                final combinedPrice = (data!.price + data.cents / 100)
                    .toStringAsFixed(2);
                return ListTile(
                  title: Text(data.name),
                  subtitle: Text('Price: $combinedPrice'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showDialog(data: data, index: index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          box.deleteAt(index);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
