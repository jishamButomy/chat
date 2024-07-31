
class MessagessList {
  List<Messages>? messages;

  MessagessList({this.messages});

  MessagessList.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  String? content;
  int? senderId;
  int? receiverId;
  String? createdAt;

  Messages(
      {this.id, this.content, this.senderId, this.receiverId, this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['createdAt'] = createdAt;
    return data;
  }
}
