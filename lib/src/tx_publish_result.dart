class TXPublishResult {
  int retCode; // 错误码
  String descMsg; // 错误描述信息
  String videoId; // 视频文件Id
  String videoURL; // 视频播放地址
  String coverURL; // 封面存储地址

  TXPublishResult({
    this.retCode,
    this.descMsg,
    this.videoId,
    this.videoURL,
    this.coverURL,
  });

  factory TXPublishResult.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return TXPublishResult(
      retCode: json['retCode'],
      descMsg: json['descMsg'],
      videoId: json['videoId'],
      videoURL: json['videoURL'],
      coverURL: json['coverURL'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonObject = Map<String, dynamic>();
    if (retCode != null) jsonObject.putIfAbsent('retCode', () => retCode);
    if (descMsg != null) jsonObject.putIfAbsent('descMsg', () => descMsg);
    if (videoId != null) jsonObject.putIfAbsent('videoId', () => videoId);
    if (videoURL != null) jsonObject.putIfAbsent('videoURL', () => videoURL);
    if (coverURL != null) jsonObject.putIfAbsent('coverURL', () => coverURL);

    return jsonObject;
  }
}
