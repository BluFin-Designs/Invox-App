import 'package:flutter/material.dart';

import '../../utils/CategoriesData.dart';
import '../Widgets/CategoryAdd_PopUp.dart';

class CategoriesPage extends StatefulWidget {
  static const routeName = '/categories';

  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  void _refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 14,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Data.allCategories[index]["color"],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Data.allCategories[index]["icon"],
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  Data.allCategories[index]["title"],
                                  style: TextStyle(
                                    color: Data.allCategories[index]["color"],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  Data.allCategories
                                      .remove(Data.allCategories[index]);
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: Data.allCategories.length,
              ),
            ),
            InkWell(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffC1C1C1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add New",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                  // barrierDismissible: false,
                  useSafeArea: true,
                  context: context,
                  builder: (_) => Dialog(
                    insetPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 260,
                      child: SingleChildScrollView(
                        child: Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "New Category",
                              style: TextStyle(
                                color: Color(0xFFFF7B54),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            CategoryAddPopUp(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).then(
                  (value) => _refreshPage(),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
