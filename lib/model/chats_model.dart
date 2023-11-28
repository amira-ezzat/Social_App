class MessageModel{

  String? sendId;
  String? receiveId;
  String? dateTime;
  String? text;
  MessageModel({
    this.sendId,
    this.receiveId,
    this.text,
    this.dateTime,
  });
  MessageModel.fromJson(Map<String,dynamic>json)
  {
    sendId=json['sendId'];
    receiveId=json['receiveId'];
    text=json['text'];
    dateTime=json['dateTime'];
  }
  Map<String,dynamic>toMap()
  {
    return{
      'sendId':sendId,
      'receiveId':receiveId,
      'text':text,
      'dateTime':dateTime,
    };
  }
}