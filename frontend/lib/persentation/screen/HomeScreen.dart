import 'package:flutter/material.dart';
import 'package:frontend/service/Apiservice.dart';
import 'package:frontend/persentation/widget/buttonwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<List<dynamic>> fetchPersons() async {
    return await Apiservice.getPersons();
  }

  void postData() async {
    Map<String, dynamic> data = {
      'pname': nameController.text,
      'pphone': phoneController.text,
      'pAge': ageController.text
    };
    bool success = await Apiservice.addPerson(data);
    if (success) {
      setState(() {});
      Navigator.pop(context);
    }
  }

  void updatePerson(int id) async {
    Map<String, dynamic> data = {
      'pname': nameController.text,
      'pphone': phoneController.text,
      'pAge': ageController.text
    };
    bool success = await Apiservice.updatePerson(id, data);
    if (success) {
      setState(() {});
      Navigator.pop(context);
    }
  }

  void deletePerson(int id) async {
    bool success = await Apiservice.deletePerson(id);
    if (success) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const Text("Welcome to CRUD Operations",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: fetchPersons(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error fetching data"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No data available"));
                  }

                  List<dynamic> persons = snapshot.data!;
                  return ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(persons[index]['pname']),
                        subtitle: Text("Phone: ${persons[index]['pphone']}, Age: ${persons[index]['pAge']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () {
                                nameController.text = persons[index]['pname'];
                                phoneController.text = persons[index]['pphone'];
                                ageController.text = persons[index]['pAge'];
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Update"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Enter Name')),
                                          TextField(controller: phoneController, decoration: const InputDecoration(hintText: 'Enter Phone No')),
                                          TextField(controller: ageController, decoration: const InputDecoration(hintText: 'Enter Age')),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(onPressed: () => updatePerson(persons[index]['id']), child: const Text("Update")),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deletePerson(persons[index]['id']),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
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
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Enter Name')),
                          TextField(controller: phoneController, decoration: const InputDecoration(hintText: 'Enter Phone No')),
                          TextField(controller: ageController, decoration: const InputDecoration(hintText: 'Enter Age')),
                        ],
                      ),
                      actions: [
                        ElevatedButton(onPressed: postData, child: const Text("Submit")),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/data/model/userModel.dart';
// import 'package:frontend/dependency%20injection/locator.dart';
// import 'package:frontend/logic/bloc/person_bloc_bloc.dart';
// import 'package:frontend/logic/bloc/person_bloc_event.dart';
// import 'package:frontend/logic/bloc/person_bloc_state.dart';

// class HomeScreen extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();

//   HomeScreen({super.key});

//   void showDialogBox(BuildContext context, String action, {int? id}) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(action),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(hintText: 'Enter Name')),
//               TextField(
//                   controller: phoneController,
//                   decoration:
//                       const InputDecoration(hintText: 'Enter Phone No')),
//               TextField(
//                   controller: ageController,
//                   decoration: const InputDecoration(hintText: 'Enter Age')),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 final bloc = locator<PersonBloc>();
//                 Map<String, dynamic> data = {
//                   'pname': nameController.text,
//                   'pphone': phoneController.text,
//                   'pAge': ageController.text
//                 };

//                 if (action == "Create") {
//                   bloc.add(AddPerson(data));
//                 } else if (action == "Update" && id != null) {
//                   bloc.add(UpdatePerson(id, data));
//                 }

//                 Navigator.pop(context);
//               },
//               child: const Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("CRUD with BLoC")),
//       body: BlocBuilder<PersonBloc, PersonState>(
//         builder: (context, state) {
//           if (state is PersonLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PersonLoaded) {
//             return ListView.builder(
//               itemCount: state.persons.length,
//               itemBuilder: (context, index) {
//                 Person person = state.persons[index];
//                 return ListTile(
//                   title: Text(person.pname),
//                   subtitle:
//                       Text("Phone: ${person.pphone}, Age: ${person.pAge}"),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () =>
//                               showDialogBox(context, "Update", id: person.id)),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => locator<PersonBloc>().add(
//                           DeletePerson(person.id),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return const Center(child: Text("No data available"));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => showDialogBox(context, "Create"),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
