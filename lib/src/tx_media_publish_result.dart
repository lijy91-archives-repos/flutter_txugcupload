class TXMediaPublishResult {
  int? retCode; // 错误码
  String? descMsg; // 错误描述信息
  String? mediaId; // 媒体文件Id
  String? mediaURL; // 媒体地址

  TXMediaPublishResult({
    this.retCode,
    this.descMsg,
    this.mediaId,
    this.mediaURL,
  });

  factory TXMediaPublishResult.fromJson(Map<String, dynamic> json) {
    return TXMediaPublishResult(
      retCode: json['retCode'],
      descMsg: json['descMsg'],
      mediaId: json['mediaId'],
      mediaURL: json['mediaURL'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonObject = Map<String, dynamic>();
    if (retCode != null) jsonObject.putIfAbsent('retCode', () => retCode);
    if (descMsg != null) jsonObject.putIfAbsent('descMsg', () => descMsg);
    if (mediaId != null) jsonObject.putIfAbsent('mediaId', () => mediaId);
    if (mediaURL != null) jsonObject.putIfAbsent('mediaURL', () => mediaURL);

    return jsonObject;
  }
}
