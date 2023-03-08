// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic/constant.dart';
import 'package:islamic/models/surah.dart';
import 'package:islamic/screens/reading_page.dart';

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;

  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();

    super.initState();
  }

  void readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWMode,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        actions: [
          Transform.rotate(
            angle: isReverse ? pi : 2 * pi,
            child: IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  setState(() {
                    isReverse = !isReverse;
                  });
                }),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
        ],
      ),
      body: Container(
        child: surahList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                color: kPrimaryColor,
              ))
            : chaptersList(isReverse ? surahList.reversed.toList() : surahList),
      ),
    );
  }

  Widget chaptersList(List<Surah> chapters) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: _controller,
      itemBuilder: (context, index) => Stack(children: [
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(154, 8, 96, 106),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                subtitle: Text(
                  "  الصفحة ${chapters[index].pageNo[0]}  -  اّياتها  ${chapters[index].versesCount}  -  ${chapters[index].revelationPlace}",
                  style: const TextStyle(color: Colors.white),
                ),
                title: Text(
                  chapters[index].arabicName,
                  style: GoogleFonts.amiri(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xfffbde1e5),
                  child: Text(
                    chapters[index].id.toString(),
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SurahPage(
                        surah: chapters[index],
                        ayat: chapters,
                        pages: chapters[index].pageNo[0],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ]),
      itemCount: chapters.length,
    );
  }
}
