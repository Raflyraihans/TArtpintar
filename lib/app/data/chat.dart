class Chat {
  int? id;
  int? groupChatId;
  String? username;
  String? message;
  String? file;
  String? createdAt;
  String? updatedAt;

  Chat(
      {this.id,
      this.groupChatId,
      this.username,
      this.message,
      this.file,
      this.createdAt,
      this.updatedAt});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupChatId = json['group_chat_id'];
    username = json['username'];
    message = json['message'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_chat_id'] = groupChatId;
    data['username'] = username;
    data['message'] = message;
    data['file'] = file;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
