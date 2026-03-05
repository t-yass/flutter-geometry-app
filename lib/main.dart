import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

///////////// TEXT STYLE ///////////////////////

const TextStyle titleStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const TextStyle subtitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.blue,
);

const TextStyle bodyStyle = TextStyle(
  fontSize: 16,
  color: Colors.black87,
);

///////////// MAIN APP ///////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penghitung Volume Bangun Ruang',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

///////////// BACKGROUND ///////////////////////

Widget backgroundWrapper(Widget child) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white, // Background putih
    child: child,
  );
}

///////////// MAIN HOME PAGE ///////////////////////

class HomePage extends StatelessWidget {
  Widget menuButton(BuildContext context, String text, String assetPath, Widget page) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade400,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              assetPath,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penghitung Volume"),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: backgroundWrapper(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Pilih Bangun Ruang",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              menuButton(context, "Kubus", "assets/appimages/kubus.jpeg", KubusPage()),
              menuButton(context, "Tabung", "assets/appimages/tabung.jpeg", TabungPage()),
              menuButton(context, "Kerucut", "assets/appimages/kerucut.jpeg", KerucutPage()),
            ],
          ),
        ),
      ),
    );
  }
}

///////////// INPUT FIELD ///////////////////////

Widget inputField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: "$label (cm)",
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

///////////// RESULT BOX ///////////////////////

Widget resultBox(double hasil) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Text(
      "Hasil: ${hasil.toStringAsFixed(2)} cm³",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    ),
  );
}

///////////// HALAMAN KUBUS ///////////////////////

class KubusPage extends StatefulWidget {
  @override
  _KubusPageState createState() => _KubusPageState();
}

class _KubusPageState extends State<KubusPage> {
  final sisiController = TextEditingController();
  double hasil = 0;

  void hitung() {
    double sisi = double.tryParse(sisiController.text) ?? 0;
    setState(() => hasil = pow(sisi, 3).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volume Kubus"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: backgroundWrapper(
        Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Rumus: V = s³", style: subtitleStyle),
                    const SizedBox(height: 25),
                    inputField("Panjang Sisi", sisiController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.blue.shade900,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onPressed: hitung,
                      child: const Text(
                        "Hitung",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    resultBox(hasil),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////// HALAMAN TABUNG ///////////////////////

class TabungPage extends StatefulWidget {
  @override
  _TabungPageState createState() => _TabungPageState();
}

class _TabungPageState extends State<TabungPage> {
  final rController = TextEditingController();
  final tController = TextEditingController();
  double hasil = 0;

  void hitung() {
    double r = double.tryParse(rController.text) ?? 0;
    double t = double.tryParse(tController.text) ?? 0;
    setState(() => hasil = pi * r * r * t);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volume Tabung"),
        backgroundColor: Colors.white,
      ),
      body: backgroundWrapper(
        Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Rumus: V = π × r² × t", style: subtitleStyle),
                    const SizedBox(height: 25),
                    inputField("Jari-jari", rController),
                    const SizedBox(height: 15),
                    inputField("Tinggi", tController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.blue.shade900,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onPressed: hitung,
                      child: const Text(
                        "Hitung",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    resultBox(hasil),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////// HALAMAN KERUCUT ///////////////////////

class KerucutPage extends StatefulWidget {
  @override
  _KerucutPageState createState() => _KerucutPageState();
}

class _KerucutPageState extends State<KerucutPage> {
  final rController = TextEditingController();
  final tController = TextEditingController();
  double hasil = 0;

  void hitung() {
    double r = double.tryParse(rController.text) ?? 0;
    double t = double.tryParse(tController.text) ?? 0;
    setState(() => hasil = (1 / 3) * pi * r * r * t);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volume Kerucut"),
        backgroundColor: Colors.white,
      ),
      body: backgroundWrapper(
        Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Rumus: V = 1/3 × π × r² × t", style: subtitleStyle),
                    const SizedBox(height: 25),
                    inputField("Jari-jari", rController),
                    const SizedBox(height: 15),
                    inputField("Tinggi", tController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.blue.shade900,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onPressed: hitung,
                      child: const Text(
                        "Hitung",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    resultBox(hasil),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}