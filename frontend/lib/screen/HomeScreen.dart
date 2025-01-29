import 'package:flutter/material.dart';
import 'package:frontend/service/Apiservice.dart';
import 'package:frontend/widget/buttonwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController ageController = TextEditingController();

    void postData() {
      Map<String, dynamic> data = {
        'pname': nameController.text,
        'pphone': phoneController.text,
        'pAge': ageController.text
      };
      Apiservice.addPerson(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD with Node.js"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Welcome to CRUD Operations",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  ButtonWidget(
                    title: "Create",
                    icon: Icons.add,
                    color: Colors.green,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Create"),
                            actions: [
                              TextField(
                                controller: nameController,
                                decoration:
                                    const InputDecoration(hintText: 'Enter a name'),
                              ),
                              TextField(
                                controller: phoneController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter a phone no'),
                              ),
                              TextField(
                                controller: ageController,
                                decoration:
                                    const InputDecoration(hintText: 'Enter a age'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      postData();
                                    },
                                    child: const Text("Summit")),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  ButtonWidget(
                    title: "Read",
                    icon: Icons.visibility,
                    color: Colors.blue,
                    onPressed: () {
                      // Read functionality
                    },
                  ),
                  ButtonWidget(
                    title: "Update",
                    icon: Icons.edit,
                    color: Colors.orange,
                    onPressed: () {
                      // Update functionality
                    },
                  ),
                  ButtonWidget(
                    title: "Delete",
                    icon: Icons.delete,
                    color: Colors.red,
                    onPressed: () {
                      // Delete functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
