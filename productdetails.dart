import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/newCategoryviewmodel.dart';
import '../model/newsCategoryModel.dart';

class Productdetails extends StatefulWidget {
  Productdetails({super.key});

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  String category = 'general'; // Default category
  final newcategorypro = Get.put(NewController());

  final List<String> btnCategoryList = [
    'General',
    'Sports',
    'Entertainment',
    'Health',
    'Business',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    // Fetch news for the default category when the screen is first loaded
    newcategorypro.getdata(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Categories"),
      ),
      body: Column(
        children: [
          // Category buttons
          Container(
            height: 60,
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: btnCategoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var btnCategory = btnCategoryList[index];
                return GestureDetector(
                  onTap: () {
                    // Update the category in the controller and fetch new data
                    newcategorypro.getdata(btnCategory.toLowerCase());
                  },
                  child: Obx(() {
                    // Determine if the current button is selected
                    bool isSelected = newcategorypro.categoryname.value ==
                        btnCategory.toLowerCase();

                    return Container(
                      margin: EdgeInsets.all(5),
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          btnCategory,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          // Display the articles (title, description, image) based on the selected category
          Expanded(
            child: Obx(() {
              if (newcategorypro.isLoading.value) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Show loading indicator
              } else if (newcategorypro.category.value == null) {
                return Center(
                    child: Text(newcategorypro
                        .errorMessage.value)); // Show error message
              } else if (newcategorypro.category.value!.articles == null ||
                  newcategorypro.category.value!.articles!.isEmpty) {
                return Center(child: Text('No articles available.'));
              } else {
                // Display the list of articles
                return ListView.builder(
                  itemCount: newcategorypro.category.value!.articles!.length,
                  itemBuilder: (context, index) {
                    var article =
                        newcategorypro.category.value!.articles![index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(article.title ?? 'No title'),
                        subtitle: Text(article.description ?? 'No description'),
                        leading: article.urlToImage != null
                            ? Image.network(article.urlToImage!,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : Icon(Icons.image, size: 50),
                        onTap: () {
                          // Handle article click, perhaps navigate to a detailed screen
                        },
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
