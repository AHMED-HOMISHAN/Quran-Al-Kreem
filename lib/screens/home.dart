// ignore_for_file: unused_import, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors, unnecessary_new, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic/constant.dart';
import 'package:islamic/models/surah.dart';
import 'package:intl/intl.dart' as intl;
import 'package:islamic/screens/azkarList.dart';
import 'package:islamic/screens/quran.dart';
import 'package:islamic/screens/reading_page.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? Ksurah;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Surah> surahList = [];
  int Kindex = 1;
  int Ki = 1;

  @override
  void initState() {
    readJson();

    super.initState();
  }

  _check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Kindex = (prefs.getInt('index') ?? Kindex);
      prefs.setString('Ksurah', surahList[Kindex - 1].arabicName);
      Ksurah = (prefs.getString('Ksurah') ?? surahList[Kindex - 1].arabicName);
    });
    setState(() {});
  }

  void readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());
    _check();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    new Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {});
    });

    void toggleMode() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _isDark = (prefs.getBool('isDark') ?? true);

      if (_isDark) {
        await (prefs.setBool('isDark', false));
        setState(() {
          colorWMode = Colors.black;
          colorBMode = Colors.white;
          colorSpMode = const Color(0xfffbde1e5);
          colorBSpMode = colorWMode;
          iconMOde = const Icon(Icons.light_mode_outlined);
        });
      } else {
        await (prefs.setBool('isDark', true));
        setState(() {
          colorBMode = Colors.black;
          colorWMode = Colors.white;
          colorSpMode = kPrimaryColor;
          colorBSpMode = const Color(0xfffbde1e5);
          iconMOde = const Icon(Icons.dark_mode_outlined);
        });
      }
      setState(() {});
    }

    String dayEN = intl.DateFormat("EEEE").format(DateTime.now());
    String dayAR = "السبت";
    int monthIndex = int.parse(HijriCalendar.now().toFormat("mm"));
    String m = "محرم";

    switch (monthIndex) {
      case 1:
        m = "محرم";
        break;
      case 2:
        m = "صفر";
        break;
      case 3:
        m = "ربيع أول";
        break;
      case 4:
        m = "ربيع ثاني";
        break;
      case 5:
        m = "جمادى الأولى";
        break;
      case 6:
        m = "جمادى الآخرة";
        break;
      case 7:
        m = "رجب";
        break;
      case 8:
        m = "شعبان";
        break;
      case 9:
        m = "رمضان";
        break;
      case 10:
        m = "شوال";
        break;
      case 11:
        m = "ذو القعدة";
        break;
      case 12:
        m = "ذو الحجة";
        break;
    }

    switch (dayEN) {
      case 'Saturday':
        dayAR = "السبت";
        break;
      case 'Sunday':
        dayAR = "الأحد";
        break;
      case 'Monday':
        dayAR = "الاثنين";
        break;
      case 'Tuesday':
        dayAR = "الثلاثاء";
        break;
      case 'Wednesday':
        dayAR = "الاربعاء";
        break;
      case 'Thursday':
        dayAR = "الخميس";
        break;
      case 'Friday':
        dayAR = "الجمعة";
        break;
    }

    return Scaffold(
      backgroundColor: colorWMode,
      appBar: AppBar(backgroundColor: kPrimaryColor, actions: [
        const Spacer(),
        IconButton(
            icon: iconMOde,
            onPressed: () {
              toggleMode();
            }),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xfffbde1e5),
                    image: const DecorationImage(
                        image: AssetImage("assets/svgs/back-ground.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(154, 8, 96, 106),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  intl.DateFormat(" a h : mm  ")
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  dayAR,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {});
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                Kindex = (prefs.getInt('index') ?? 1);
                                Ki = (prefs.getInt('i') ?? 1);
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          SurahPage(
                                        surah: surahList[Kindex - 1],
                                        ayat: surahList,
                                        pages: surahList[Ki].pageNo[0],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    "الاية المحفوضة",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    Ksurah != null
                                        ? Ksurah.toString()
                                        : "لا يوجد اية محفوظة",
                                    style: GoogleFonts.amiri(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  (DateTime.now().toString().substring(0, 10)),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  (HijriCalendar.now()
                                      .toFormat("dd/$m/yyyy")
                                      .toString()),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Quran()));
              },
              child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(154, 8, 96, 106),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/splash.svg',
                        fit: BoxFit.cover,
                        width: 90,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text(
                        "القراّن الكريم",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  )),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const azkarList(id: 2)));
                  },
                  child: Container(
                      width: 170,
                      height: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(154, 8, 96, 106),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset(
                          'assets/svgs/doa-icon.svg',
                          fit: BoxFit.cover,
                          height: 45,
                        ),
                        const Text(
                          "أدعية",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      ])),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const azkarList(id: 1)));
                    },
                    child: Container(
                        width: 170,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(154, 8, 96, 106),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SvgPicture.asset(
                            'assets/svgs/bead.svg',
                            fit: BoxFit.cover,
                            height: 45,
                          ),
                          const Text(
                            "أذكار",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ])))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
