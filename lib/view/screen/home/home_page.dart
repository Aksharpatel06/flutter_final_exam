import 'package:flutter/material.dart';
import 'package:flutter_final_exam/utils/color.dart';
import 'package:flutter_final_exam/view/controller/home_controller.dart';
import 'package:flutter_final_exam/view/screen/details/details_page.dart';
import 'package:flutter_final_exam/view/screen/stoarage/stoarage_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {
                Get.to(() => StoaragePage(),
                    duration: Duration(milliseconds: 1000),
                    transition: Transition.leftToRight);
              },
              icon: const Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBar(

            onChanged: (value) {
              homeController.searchData(value);
            },
          ),
          Expanded(
            child: Obx(
              () => (homeController.notesList.isEmpty)
                  ? Center(
                      child: Text(
                        'Notes is Empty',
                        style: TextStyle(color: primaryColor, fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: homeController.notesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                homeController.notesList[index].title,
                                style: TextStyle(color: primaryColor),
                              ),
                              subtitle: Text(
                                homeController.notesList[index].content,
                                style: TextStyle(color: primaryColor),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        homeController.editDetails(index);
                                        Get.to(() => const DetailsPage(),
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            transition: Transition.leftToRight);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: primaryColor,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        homeController.deleteNotes(index);
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: primaryColor,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.isUpadate.value = false;
          Get.to(() => const DetailsPage(),
              duration: const Duration(milliseconds: 1000),
              transition: Transition.leftToRight);
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
