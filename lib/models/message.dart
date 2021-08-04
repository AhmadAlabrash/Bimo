class Message {
  String? reciverId;
  String? imageLink;
  String? date;
  String? messageText;

  Message({this.reciverId, this.imageLink, this.date, this.messageText});

  Message.fromJson(Map<String, dynamic> json) {
    reciverId = json['ReciverId'];
    imageLink = json['imageLink'];
    date = json['date'];
    messageText = json['messageText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReciverId'] = this.reciverId;
    data['imageLink'] = this.imageLink;
    data['date'] = this.date;
    data['messageText'] = this.messageText;
    return data;
  }
}
