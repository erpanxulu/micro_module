class MusicResponse {
  final int status;
  final String message;
  final InfoData infoData;
  final List<MusicItem> listData;

  MusicResponse({
    required this.status,
    required this.message,
    required this.infoData,
    required this.listData,
  });

  factory MusicResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return MusicResponse(
      status: data['status'] as int,
      message: data['msg'] as String,
      infoData: InfoData.fromJson(data['info_data']),
      listData: (data['list_data'] as List)
          .map((item) => MusicItem.fromJson(item))
          .toList(),
    );
  }
}

class InfoData {
  final int total;
  final int page;
  final int rowPerPage;
  final int totalPage;

  InfoData({
    required this.total,
    required this.page,
    required this.rowPerPage,
    required this.totalPage,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      total: json['total'] as int,
      page: json['page'] as int,
      rowPerPage: json['row_per_page'] as int,
      totalPage: json['total_page'] as int,
    );
  }
}

class MusicItem {
  final String originalName;
  final int duration;
  final int mediaSize;
  final String filename;
  final String mediaUrl;
  final int creationTime;
  final String kode;
  final String keyId;
  final String mimeType;

  MusicItem({
    required this.originalName,
    required this.duration,
    required this.mediaSize,
    required this.filename,
    required this.mediaUrl,
    required this.creationTime,
    required this.kode,
    required this.keyId,
    required this.mimeType,
  });

  factory MusicItem.fromJson(Map<String, dynamic> json) {
    return MusicItem(
      originalName: json['originalName'] as String,
      duration: json['duration'] as int,
      mediaSize: json['mediaSize'] as int,
      filename: json['filename'] as String,
      mediaUrl: json['mediaUrl'] as String,
      creationTime: json['creationTime'] as int,
      kode: json['kode'] as String,
      keyId: json['keyId'] as String,
      mimeType: json['mimeType'] as String,
    );
  }
}
