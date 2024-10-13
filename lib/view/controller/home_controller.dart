import 'package:flutter/material.dart';
import 'package:flutter_final_exam/view/helper/db_services.dart';
import 'package:flutter_final_exam/view/helper/google_services.dart';
import 'package:flutter_final_exam/view/modal/notes_modal.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSearch = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  TextEditingController txtContent = TextEditingController();
  DateTime dateTime = DateTime.now();
  RxString category ='Work'.obs;
  RxList<NotesModal> notesList = <NotesModal>[].obs;
  RxBool isUpadate = false.obs;
  RxInt updateIndex = 0.obs;
  var key = GlobalKey<FormState>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DbService.dbService.database;
    getDataList();
  }

  Future<void> getDataList()
  async {
    List notes = await DbService.dbService.dataShow();
    notesList.value = notes.map((e) => NotesModal(e),).toList();
    update();
    notesList.refresh();
  }

  void searchData(String value)
  {
    if(value.isNotEmpty || value!='')
      {
        notesList.value = notesList.where((notes) => notes.title.contains(value),).toList();
      } else{
      getDataList();
    }
    update();
    notesList.refresh();
  }

  void deleteNotes(int index)
  {
    DbService.dbService.deleteData(notesList[index].id);
    notesList.removeAt(index);
    update();
    notesList.refresh();
  }

  void editDetails(int index)
  {
    updateIndex.value = index;
    isUpadate.value = true;
    txtTitle = TextEditingController(text: notesList[index].title);
    txtContent = TextEditingController(text: notesList[index].content);
    category.value = notesList[index].category;
    update();
  }


  void allDataStoreToDatabase()
  {
    for(NotesModal notes in notesList)
      {
        GoogleServices.googleServices.addToAllDataStoreToFirebase(notes.modalToMap(notes));
      }
  }
}