// ignore_for_file: unused_import, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:islamic/constant.dart';
import 'package:islamic/models/surah.dart';
import 'package:islamic/screens/home.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

class SurahPage extends StatefulWidget {
  final Surah surah;
  final List<Surah> ayat;
  final int pages;

  const SurahPage({
    super.key,
    required this.surah,
    required this.ayat,
    required this.pages,
  });

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  List<Surah> surahList = [];
  String name = "";
  String curr_name = "";
  int temp = 1;
  int tempindex = 1;
  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    if (widget.surah.id == 114) {
      name = surahList[0].arabicName;
    } else {
      name = surahList[widget.surah.id].arabicName;
    }
    curr_name = surahList[widget.surah.id - 1].arabicName;

    debugPrint(surahList.length.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    temp = (prefs.getInt('i') ?? 1);
    tempindex = (prefs.getInt('index') ?? 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.surah.versesCount;
    int index = widget.surah.id;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorWMode,
        appBar: null,
        body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: header(),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
              text: TextSpan(
                children: [
                  for (var i = 1; i <= count; i++) ...{
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          setState(() {});
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('i', i);
                          await prefs.setInt('index', index);
                          prefs.setString(
                              'Ksurah', widget.ayat[index - 1].arabicName);

                          setState(() {
                            Ksurah = (prefs.getString('Ksurah') ??
                                widget.ayat[index - 1].arabicName);
                            temp = (prefs.getInt('i') ?? i);
                            tempindex = (prefs.getInt('index') ?? index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor:
                                    const Color.fromARGB(226, 7, 75, 82),
                                behavior: SnackBarBehavior.floating,
                                content: const Text("تم حفظ الاية بنجاح"),
                              ),
                            );
                          });
                        },
                      text:
                          ' ${quran.getVerse(index, i, verseEndSymbol: false)} ',
                      style: TextStyle(
                        fontFamily: 'Kitab',
                        fontSize: 25,
                        color: temp == i && tempindex == index
                            ? Colors.red
                            : colorBMode,
                      ),
                    ),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: kPrimaryColor,
                          child: Text(
                            '$i',
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: i.toString().length <= 2 ? 1 : .8,
                          ),
                        ))
                  }
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (index == (114)) {
                  index = 0;
                } else {
                  index = index;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SurahPage(
                      surah: surahList[index],
                      ayat: widget.ayat,
                      pages: surahList[index].pageNo[0],
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor),
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
              height: 170,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage("assets/svgs/background.jpg"),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(178, 8, 96, 106),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  (curr_name),
                                  style: GoogleFonts.amiri(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                        const Spacer(),
                        Text(
                          "  الصفحة ${widget.pages}  -  اّياتها  ${widget.surah.versesCount}  -  ${widget.surah.revelationPlace}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                SvgPicture.asset('assets/svgs/bismillah.svg'),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
