import 'dart:convert';
import 'package:flutter_application_pdf/file_models.dart';
import 'package:http/http.dart' as http;

class FetchFileServeice{
  Future<List<Getfile>> getFile() async{
    final response = await http.get(Uri.parse('https://cha-qa-qc-test.azurewebsites.net/api/Standards/a1/file'),
     headers: <String,String>{ "Access-Control-Allow-Origin": "*", 
      "Access-Control-Allow-Credentials":
          'true', 
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"}
    );
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      List<Getfile> getfile = body
                    .map((dynamic item) => Getfile.fromJson(item))
                    .toList();
        print(getfile);
        return getfile;
        
    }
    else{
      throw Exception('failed');
    }

  }
}