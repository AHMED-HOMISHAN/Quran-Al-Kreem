import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic/constant.dart';
import 'package:islamic/models/azakar.dart';

class Azkardetials extends StatefulWidget {
  final int id;
  const Azkardetials({super.key, required this.id});

  @override
  State<Azkardetials> createState() => _AzkardetialsState();
}

class _AzkardetialsState extends State<Azkardetials> {
  String title = "";
  List<Azakar> azakarList = [];
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();
    super.initState();
  }

  void readJson() async {
    final String response = await rootBundle.loadString("assets/azkar.json");
    String? ch;
    final data = await json.decode(response);
    switch (widget.id) {
      case 1:
        ch = "chapters";
        title = "أذكار الصباح";
        break;
      case 2:
        ch = "chapters1";
        title = "أذكار المساء";
        break;
      case 3:
        ch = "chapters3";
        title = "أذكار الاستيقاظ";
        break;
      case 4:
        ch = "chapters4";
        title = "أذكار النوم";
        break;
      case 5:
        ch = "chapters5";
        title = " تسابيح ";
        break;
      case 6:
        ch = "chapters6";
        title = "أذكار بعد الصلاة";
        break;
      case 7:
        ch = "chapters7";
        title = " أدعية قرانية ";
        break;
      case 8:
        ch = "chapters8";
        title = "أدعية الأنبياء ";
        break;
    }
    for (var item in data[ch]) {
      azakarList.add(Azakar.fromMap(item));
    }
    debugPrint(azakarList.length.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWMode,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Container(child: chaptersList(azakarList)),
    );
  }

  Widget chaptersList(List<Azakar> chapters) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: _controller,
      itemBuilder: (context, index) => Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: azakarList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ))
                  : Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 234, 234),
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 216, 218, 220),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "عددالمرات : ${chapters[index].count}",
                                    style: const TextStyle())),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              chapters[index].content.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (chapters[index].description.isNotEmpty) ...{
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                chapters[index].description.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            }
                          ],
                        ),
                      ),
                    ),
            ),

            // SizedBox(
            //   child: Text(
            //     chapters[index].description,
            //     style: GoogleFonts.cairo(
            //       color: colorBMode,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      itemCount: chapters.length,
    );
  }
}
