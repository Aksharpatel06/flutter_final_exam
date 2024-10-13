import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_exam/utils/color.dart';
import 'package:flutter_final_exam/view/controller/home_controller.dart';
import 'package:flutter_final_exam/view/helper/google_services.dart';
import 'package:flutter_final_exam/view/modal/notes_modal.dart';
import 'package:get/get.dart';

class StoaragePage extends StatelessWidget {
  const StoaragePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: primaryColor,
                    title: const Text(
                        'will you storage to the data int the app ?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            homeController.allDataStoreToDatabase();
                            Navigator.pop(context);
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.storage_rounded))
        ],
      ),
      body: StreamBuilder(
        stream: GoogleServices.googleServices.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle if there's an error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData) {
            final users = snapshot.data!;

            List<NotesModal> notesList =
                users.docs.map((e) => NotesModal(e.data() as Map)).toList();

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        notesList[index].title,
                        style: const TextStyle(color: primaryColor),
                      ),
                      subtitle: Text(
                        notesList[index].content,
                        style: const TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          // If no snapshot data is available
          return const Center(child: Text("No data available."));
        },
      ),
    );
  }
}
