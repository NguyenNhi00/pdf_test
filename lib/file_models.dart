
class Getfile {
  String? standardId;
  String? fileData;

  Getfile({this.standardId, this.fileData});

  Getfile.fromJson(Map<String, dynamic> json) {
    standardId = json['standardId'];
    fileData = json['fileData'];
  }
}