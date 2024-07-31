class ChatUserList {
  int? id;
  String? email;
  String? password;
  String? username;
  bool? isEmailverified;
  LastMessage? lastMessage;
  String? imageUrl;

  ChatUserList(
      {this.id,
        this.email,
        this.password,
        this.username,
        this.isEmailverified,
        this.imageUrl,
        this.lastMessage});

  ChatUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    imageUrl=json['profilePic'];
    password = json['password'];
    username = json['username'];
    isEmailverified = json['isEmailverified'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['username'] = username;
    data['isEmailverified'] = isEmailverified;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    return data;
  }
}

class LastMessage {
  String? message;
  String? timestamp;
  String? type;

  LastMessage({this.message, this.timestamp, this.type});

  LastMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timestamp = json['timestamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['timestamp'] = timestamp;
    data['type'] = type;
    return data;
  }
}
