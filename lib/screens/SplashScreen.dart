// ignore_for_file: file_names, use_build_context_synchronously, use_full_hex_values_for_flutter_colors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic/constant.dart';
import 'package:islamic/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setState(() {
      _check();
    });
    _navigatetohome();

    super.initState();
  }

  _check() async {
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isDark = (prefs.getBool('isDark') ?? true);

    if (_isDark) {
      setState(() {
        colorBMode = Colors.black;
        colorWMode = Colors.white;
        colorSpMode = kPrimaryColor;
        colorBSpMode = const Color(0xfffbde1e5);
        iconMOde = const Icon(Icons.dark_mode_outlined);
      });
    } else {
      setState(() {
        colorWMode = Colors.black;
        colorBMode = Colors.white;
        colorSpMode = const Color(0xfffbde1e5);
        colorBSpMode = colorWMode;
        iconMOde = const Icon(Icons.light_mode_outlined);
      });
    }
    setState(() {});
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child: _getlogo()),
            const SizedBox(height: 20, width: 20),
            const SizedBox(height: 20, width: 20),
            Text('By AHMED SAMEER',
                style: TextStyle(
                  color: colorSpMode,
                )),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      backgroundColor: colorBSpMode,
    );
  }
}

Widget _getlogo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset('assets/svgs/splash.svg'),
    ],
  );
}
