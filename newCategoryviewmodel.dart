import 'dart:io';

import 'package:furnitureapp/model/newsCategoryModel.dart';
import 'package:get/get.dart';
import '../repo/newscategory.dart';

class NewController extends GetxController {
  NewscategoryRepo newscategoryRepo = NewscategoryRepo();

  // Observable for a list of category data
  var category = Rx<newModelca?>(null);
  var categoryname = ''.obs; // Name of the category
  var isLoading = false.obs; // Loading state
  var errorMessage = ''.obs; // Error message if any

  // Fetch the data for a given category
  Future<void> getdata(String categories) async {
    if (categories.isEmpty) {
      errorMessage.value = 'Category name cannot be empty.';
      return;
    }

    isLoading.value = true; // Show loading state
    try {
      var response =
          await newscategoryRepo.getNewsRepo(categories); // Await the response
      if (response != null) {
        category.value = response; // Assign response to category
        categoryname.value = categories; // Assign category name
        errorMessage.value = ''; // Clear any error message
      } else {
        errorMessage.value = 'No data found for the category.';
      }
    } on SocketException {
      errorMessage.value = 'No internet connection.';
    } catch (e) {
      errorMessage.value = 'Error: $e'; // Set error message if an error occurs
    } finally {
      isLoading.value = false; // Hide loading state
    }
  }
}
