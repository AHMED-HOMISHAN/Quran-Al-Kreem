import 'package:flutter/material.dart';
import 'package:islamic/constant.dart';
import 'package:islamic/screens/azkardetials.dart';

class azkarList extends StatefulWidget {
  final int id;
  const azkarList({super.key, required this.id});

  @override
  State<azkarList> createState() => _azkarListState();
}

class _azkarListState extends State<azkarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.id == 1 ? const Text("أذكار") : const Text("أدعية"),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      backgroundColor: colorWMode,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              if (widget.id == 1) ...{
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 1)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أذكار الصباح",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 2)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أذكار المساء",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 3)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أذكار الاستيقاظ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 4)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أذكار النوم",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 5)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "تسابيح ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 6)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أذكار بعد الصلاة",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
              } else ...{
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 7)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أدعية قرآنية",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Azkardetials(id: 8)));
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 8, 96, 106),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "أدعية الأنبياء",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
