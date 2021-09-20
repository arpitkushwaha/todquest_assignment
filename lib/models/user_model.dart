class UserModel{

  String timestamp;
  String name;
  String email;

  UserModel({this.timestamp, this.name, this.email});

  static List<DateTime> sortData(Map<String, dynamic> data) {
    List<DateTime> temp = [];
    data.forEach((key, value) {
      temp.add(DateTime.parse(key));
    });
    temp.sort();
    temp = new List.from(temp.reversed);
    temp.forEach((element) {
      print(element);
    });
    return temp;
  }
}