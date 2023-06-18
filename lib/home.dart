import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var api
  String base_url = 'http://192.168.76.57:5000/api';
  String base_url_img = 'http://192.168.76.57:5000/static/save_model/';
  // get
  String? classificationReportImage;
  String? confusionMatrixImage;
  double? accuracy;
  // post
  String? labelName;
  String? reccomendationName;

  // var local
  File? _image;
  int _selectedIndex = 0;

  bool tapped = false;

  Future getImageFromGallery() async {
    var imageGallery =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      if (imageGallery != null) {
        _image = File(imageGallery.path);
      }
    });
  }

  Future getImageFromCamera() async {
    var imageCamera =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);

    setState(() {
      if (imageCamera != null) {
        _image = File(imageCamera.path);
      }
    });
  }

  Future<void> fetchDataTrainTest() async {
    final response = await http.get(Uri.parse('$base_url/training-testing/'));
    print(response);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        classificationReportImage = data['classification_report_image'];
        confusionMatrixImage = data['confusion_matrix_image'];
        accuracy = data['getAccuracy'];
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> uploadImage() async {
    final url = Uri.parse('$base_url/testing-manually/');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      setState(() {
        labelName = data['labelName'];
        reccomendationName = data['recommendationName'];
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchDataTrainTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[900]),
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 60.0,
                                left: 30.0,
                                right: 30.0,
                                bottom: 30.0,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: const Text(
                                'Halaman Utama',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: const Text(
                                'Selamat Datang di "Aplikasi Rekomendasi Takaran Pupuk Urea Pada Tanaman Padi Melalui Citra BWD Menggunakan Metode K-NN"',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          const BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(5, 5),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                            color: Colors.grey.shade800,
                                            offset: const Offset(-4, -4),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        'assets/images/haidar.jpg',
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 20.0),
                                        child: const Text(
                                          'Muhammad Haidar',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 3.0),
                                        child: const Text(
                                          '192410103002',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 3.0),
                                        child: const Text(
                                          'Universitas Jember',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5.0),
                                        child: const Text(
                                          'muhammadhaidar862@gmail.com',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin:
                                          const EdgeInsets.only(bottom: 15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.green[500],
                                          // borderRadius: BorderRadius.circular(12),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(8, 8),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-5, -5),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            )
                                          ]),
                                      child: const Text(' '),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 30.0,
                                        right: 15.0,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-3, -3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.dataset_linked,
                                            color: Colors.white,
                                            size: 100.0,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: accuracy != null
                                                ? const Text(
                                                    'Total Dataset : 6000',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                                : const CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 15.0,
                                        right: 30.0,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-3, -3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.bar_chart_outlined,
                                            color: Colors.white,
                                            size: 100.0,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: accuracy != null
                                                ? Text(
                                                    'Akurasi : ${accuracy!.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                                : const CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 30.0,
                                        right: 15.0,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-3, -3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.abc_outlined,
                                            color: Colors.white,
                                            size: 100.0,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: accuracy != null
                                                ? const Text(
                                                    'Nilai K : 4',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                                : const CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 15.0,
                                        right: 30.0,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-3, -3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.info_outline,
                                            color: Colors.white,
                                            size: 100.0,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: const Text(
                                              'Versi : 1.0.0',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 70.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 60.0,
                          left: 30.0,
                          right: 30.0,
                          bottom: 30.0,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: const Text(
                          'Halaman Dataset',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 60.0,
                                left: 30.0,
                                right: 30.0,
                                bottom: 30.0,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: const Text(
                                'Halaman Percobaan & Pengujian',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: const Text(
                                'Pengujian data menggunakan data sebanyak 80% Data Training & 20% Data Testing Dari total 6000 dataset.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 30.0,
                                        right: 15.0,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-3, -3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.abc_outlined,
                                            color: Colors.white,
                                            size: 100.0,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: accuracy != null
                                                ? const Text(
                                                    'Nilai K : 4',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                                : const CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 15.0,
                                        right: 30.0,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade800,
                                              offset: const Offset(-3, -3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                              inset: true,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.bar_chart_outlined,
                                            color: Colors.white,
                                            size: 100.0,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'Akurasi : ${accuracy?.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Classification Report : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: classificationReportImage != null
                                        ? Image.network(
                                            '$base_url_img${classificationReportImage!}')
                                        : Image.asset(
                                            'assets/images/thumbnail.jpg',
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Confusion Matrix : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: confusionMatrixImage != null
                                        ? Image.network(
                                            '$base_url_img${confusionMatrixImage!}')
                                        : Image.asset(
                                            'assets/images/thumbnail.jpg',
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 70.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 60.0,
                                left: 30.0,
                                right: 30.0,
                                bottom: 30.0,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: const Text(
                                'Halaman Pengujian Label',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Leaf Color Chart (Bagan Warna Daun) : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      'assets/images/leaf_color_chart.jpg',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: GestureDetector(
                                      onTap: getImageFromGallery,
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                          top: 30.0,
                                          left: 30.0,
                                          right: 15.0,
                                        ),
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[900],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              const BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(4, 4),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                                inset: false,
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                offset: const Offset(-3, -3),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                                inset: false,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.photo_outlined,
                                              color: Colors.white,
                                              size: 100.0,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: const Text(
                                                'Buka Galeri',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: GestureDetector(
                                      onTap: getImageFromCamera,
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                          top: 30.0,
                                          left: 15.0,
                                          right: 30.0,
                                        ),
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[900],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              const BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(4, 4),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                                inset: false,
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                offset: const Offset(-3, -3),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                                inset: false,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.photo_camera_outlined,
                                              color: Colors.white,
                                              size: 100.0,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: const Text(
                                                'Buka Kamera',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Gambar : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                  ),
                                  Center(
                                    child: _image == null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              'assets/images/thumbnail.jpg',
                                              height: 150.0,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.file(
                                              _image!,
                                              height: 150.0,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => uploadImage(),
                              onTapDown: (TapDownDetails details) {
                                setState(() {
                                  tapped = true;
                                });
                              },
                              onTapUp: (TapUpDetails details) {
                                setState(() {
                                  tapped = false;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                  top: 30.0,
                                  left: 50.0,
                                  right: 50.0,
                                ),
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: const Offset(4, 4),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                        inset: tapped,
                                      ),
                                      BoxShadow(
                                        color: Colors.grey.shade800,
                                        offset: const Offset(-3, -3),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                        inset: tapped,
                                      )
                                    ]),
                                child: const Text(
                                  'Klik Untuk Memproses Gambar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade800,
                                      offset: const Offset(-3, -3),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hasil Pengecekan',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                  ),
                                  labelName == null
                                      ? const Text(
                                          'Label                     : ?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      : Text(
                                          'Label                     : $labelName',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                  reccomendationName == null
                                      ? const Text(
                                          'Takaran Pupuk    : ?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      : Text(
                                          'Takaran Pupuk    : $reccomendationName',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 70.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              // margin: const EdgeInsets.only(
              //   top: 30.0,
              //   left: 30.0,
              //   right: 30.0,
              //   bottom: 30.0,
              // ),
              // padding: const EdgeInsets.only(
              //   top: 25.0,
              //   left: 25.0,
              //   right: 25.0,
              // ),
              padding: const EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 4),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade800,
                      offset: const Offset(-3, -3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildNavItem(Icons.home, 0),
                  // buildNavItem(Icons.dataset, 1),
                  buildNavItem(Icons.graphic_eq_outlined, 2),
                  buildNavItem(Icons.picture_in_picture, 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: _selectedIndex == index
                  ? const Offset(3, 3)
                  : const Offset(5, 5),
              blurRadius: 4,
              spreadRadius: 1,
              inset: _selectedIndex == index,
            ),
            BoxShadow(
              color: Colors.grey.shade800,
              offset: _selectedIndex == index
                  ? const Offset(-2, -2)
                  : const Offset(-4, -4),
              blurRadius: 4,
              spreadRadius: 1,
              inset: _selectedIndex == index,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.white : Colors.grey[500],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
