import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

import 'file_models.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title = 'PDF';


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
       SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Center(
           child: Container(
            width: 700,
            height: 700,
            child: FutureBuilder<Uint8List>(
              future: _fetchPdfContent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PdfPreview(
                    allowPrinting: false,
                    allowSharing: false,
                    canChangePageFormat: false,
                    initialPageFormat:
                        const PdfPageFormat(100 * PdfPageFormat.mm, 120 * PdfPageFormat.mm),
                    build: (format) => snapshot.data!,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
               ),
         ),
       ),
    );
  }

  Future<Uint8List> _fetchPdfContent() async {
    Uint8List uint8list = Uint8List(12);
    try {
     final res = await http.get(Uri.parse('https://cha-qa-qc-test.azurewebsites.net/api/Standards/a1/file'),
      headers: <String,String>{ "Access-Control-Allow-Origin": "*", 
      "Access-Control-Allow-Credentials":
          'true', 
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"}
    );
    if(res.statusCode == 200){
      final jsonresponse = jsonDecode(res.body);
      final jsonDatafile = jsonresponse['fileData'];
                   
        print(jsonDatafile);

        uint8list = base64Decode(jsonDatafile);
        
    }
      return uint8list;
    } catch (e) {
      print(e);
      throw Exception('');
    }
  }
}