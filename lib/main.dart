import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

//////////////////////////////////////////////////
// STYLE TEXT GLOBAL
//////////////////////////////////////////////////

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

//////////////////////////////////////////////////
// MAIN APP
//////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penghitung Volume Bangun Ruang',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

//////////////////////////////////////////////////
// HALAMAN UTAMA
//////////////////////////////////////////////////

Widget backgroundWrapper(Widget child) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/appimages/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      child
    ],
  );
}

class HomePage extends StatelessWidget {

  Widget menuButton(BuildContext context, String text, Widget page) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Penghitung Volume", style: titleStyle),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),

      body: backgroundWrapper(

        Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Pilih Bangun Ruang",
                style: subtitleStyle,
              ),

              SizedBox(height: 30),

              menuButton(context, "Kubus", KubusPage()),
              menuButton(context, "Tabung", TabungPage()),
              menuButton(context, "Kerucut", KerucutPage()),

            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// INPUT FIELD
//////////////////////////////////////////////////

Widget inputField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: "$label (cm)",
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

//////////////////////////////////////////////////
// RESULT BOX
//////////////////////////////////////////////////

Widget resultBox(double hasil) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
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

//////////////////////////////////////////////////
// HALAMAN KUBUS
//////////////////////////////////////////////////

class KubusPage extends StatefulWidget {
  @override
  _KubusPageState createState() => _KubusPageState();
}

class _KubusPageState extends State<KubusPage> {

  final sisiController = TextEditingController();
  double hasil = 0;

  void hitung() {
    double sisi = double.parse(sisiController.text);
    setState(() {
      hasil = pow(sisi, 3).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Volume Kubus", style: titleStyle),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: SingleChildScrollView(

          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Padding(
              padding: EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Rumus Volume Kubus", style: subtitleStyle),
                  SizedBox(height: 10),

                  Text("V = s³", style: bodyStyle),
                  Text("s = panjang sisi (cm)", style: bodyStyle),

                  SizedBox(height: 10),

                  Text("Contoh:", style: bodyStyle),
                  Text("Jika sisi = 4 cm", style: bodyStyle),
                  Text("V = 4 × 4 × 4 = 64 cm³", style: bodyStyle),

                  SizedBox(height: 25),

                  inputField("Panjang Sisi", sisiController),

                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: hitung,
                    child: Text("Hitung"),
                  ),

                  SizedBox(height: 20),

                  resultBox(hasil),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// HALAMAN TABUNG
//////////////////////////////////////////////////

class TabungPage extends StatefulWidget {
  @override
  _TabungPageState createState() => _TabungPageState();
}

class _TabungPageState extends State<TabungPage> {

  final rController = TextEditingController();
  final tController = TextEditingController();
  double hasil = 0;

  void hitung() {
    double r = double.parse(rController.text);
    double t = double.parse(tController.text);

    setState(() {
      hasil = pi * r * r * t;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Volume Tabung", style: titleStyle),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: SingleChildScrollView(

          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Padding(
              padding: EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Rumus Volume Tabung", style: subtitleStyle),

                  SizedBox(height: 10),

                  Text("V = π × r² × t", style: bodyStyle),
                  Text("π = 3.14", style: bodyStyle),
                  Text("r = jari-jari alas (cm)", style: bodyStyle),
                  Text("t = tinggi (cm)", style: bodyStyle),

                  SizedBox(height: 10),

                  Text("Contoh:", style: bodyStyle),
                  Text("Jika r = 7 cm dan t = 10 cm", style: bodyStyle),
                  Text("V = 3.14 × 7 × 7 × 10 = 1538.6 cm³", style: bodyStyle),

                  SizedBox(height: 25),

                  inputField("Jari-jari", rController),
                  SizedBox(height: 15),
                  inputField("Tinggi", tController),

                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: hitung,
                    child: Text("Hitung"),
                  ),

                  SizedBox(height: 20),

                  resultBox(hasil),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// HALAMAN KERUCUT
//////////////////////////////////////////////////

class KerucutPage extends StatefulWidget {
  @override
  _KerucutPageState createState() => _KerucutPageState();
}

class _KerucutPageState extends State<KerucutPage> {

  final rController = TextEditingController();
  final tController = TextEditingController();
  double hasil = 0;

  void hitung() {
    double r = double.parse(rController.text);
    double t = double.parse(tController.text);

    setState(() {
      hasil = (1/3) * pi * r * r * t;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Volume Kerucut", style: titleStyle),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: SingleChildScrollView(

          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Padding(
              padding: EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Rumus Volume Kerucut", style: subtitleStyle),

                  SizedBox(height: 10),

                  Text("V = 1/3 × π × r² × t", style: bodyStyle),
                  Text("π = 3.14", style: bodyStyle),
                  Text("r = jari-jari alas (cm)", style: bodyStyle),
                  Text("t = tinggi (cm)", style: bodyStyle),

                  SizedBox(height: 10),

                  Text("Contoh:", style: bodyStyle),
                  Text("Jika r = 7 cm dan t = 9 cm", style: bodyStyle),
                  Text("V = 1/3 × 3.14 × 7 × 7 × 9 = 461.58 cm³", style: bodyStyle),

                  SizedBox(height: 25),

                  inputField("Jari-jari", rController),
                  SizedBox(height: 15),
                  inputField("Tinggi", tController),

                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: hitung,
                    child: Text("Hitung"),
                  ),

                  SizedBox(height: 20),

                  resultBox(hasil),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}