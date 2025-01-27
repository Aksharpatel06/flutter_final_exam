import 'package:flutter/material.dart';
import 'package:flutter_final_exam/utils/color.dart';
import 'package:flutter_final_exam/view/controller/home_controller.dart';
import 'package:flutter_final_exam/view/helper/db_services.dart';
import 'package:get/get.dart';

import 'componects/text_field_details.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Add to Notes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: homeController.key,
          child: Column(
            children: [
              TextFiledDetails(
                txtName: homeController.txtTitle,
                text: 'title',
              ),
              TextFiledDetails(
                txtName: homeController.txtContent,
                text: 'content',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'DateTime : ',
                      style: TextStyle(
                        color: ternaryColor,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          onDatePickerModeChange: (value) {
                            homeController.dateTime = value as DateTime;
                          },
                        );
                      },
                      child: Text('Select Date',
                          style: TextStyle(
                              color: Colors.blue.shade200,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue.shade200)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categorize  : ',
                      style: TextStyle(
                        color: ternaryColor,
                        fontSize: 18,
                      ),
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return DropdownButton(
                          value: controller.category.value,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: ternaryColor,
                          ),
                          elevation: 16,
                          style: const TextStyle(color: primaryColor),
                          underline: Container(
                            height: 2,
                            color: secondaryColor,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Work',
                              child: Text('Work'),
                            ),
                            DropdownMenuItem(
                              value: 'Personal',
                              child: Text('Personal'),
                            ),
                            DropdownMenuItem(
                              value: 'Miscellaneous',
                              child: Text('Miscellaneous'),
                            ),
                          ],
                          onChanged: (value) {
                            controller.category.value = value!;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (homeController.key.currentState!.validate()) {
                        Map json = {
                          'Title': homeController.txtTitle.text,
                          'Content': homeController.txtContent.text,
                          'Datetime':
                              '${homeController.dateTime.day}-${homeController.dateTime.month}',
                          'Category': homeController.category.value
                        };
                        if (homeController.isUpadate.value) {
                          DbService.dbService.updateDatabase(
                              json,
                              homeController
                                  .notesList[homeController.updateIndex.value]
                                  .id);
                        } else {
                          DbService.dbService.insertDatabase(json);
                        }
                        homeController.txtTitle.clear();
                        homeController.txtContent.clear();
                        Navigator.pop(context);
                        homeController.getDataList();
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ternaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      child: Text(
                        homeController.isUpadate.value ? 'Update' : 'Save',
                        style: const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

