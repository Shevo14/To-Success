class ContentItem {
  final String id;
  final String classId;
  final String title;
  final String description;
  final String storagePath;
  final String mimeType;
  final int sizeBytes;
  final Duration? lastPosition; // for videos
  final DateTime uploadedAt;

  const ContentItem({
    required this.id,
    required this.classId,
    required this.title,
    required this.description,
    required this.storagePath,
    required this.mimeType,
    required this.sizeBytes,
    required this.lastPosition,
    required this.uploadedAt,
  });

  Map<String, dynamic> toMap() => {
        'classId': classId,
        'title': title,
        'description': description,
        'storagePath': storagePath,
        'mimeType': mimeType,
        'sizeBytes': sizeBytes,
        'lastPosition': lastPosition?.inMilliseconds,
        'uploadedAt': uploadedAt.toIso8601String(),
      };

  factory ContentItem.fromMap(String id, Map<String, dynamic> map) => ContentItem(
        id: id,
        classId: (map['classId'] ?? '') as String,
        title: (map['title'] ?? '') as String,
        description: (map['description'] ?? '') as String,
        storagePath: (map['storagePath'] ?? '') as String,
        mimeType: (map['mimeType'] ?? '') as String,
        sizeBytes: (map['sizeBytes'] ?? 0) as int,
        lastPosition: map['lastPosition'] == null ? null : Duration(milliseconds: (map['lastPosition'] as num).toInt()),
        uploadedAt: DateTime.tryParse((map['uploadedAt'] ?? '') as String) ?? DateTime.now(),
      );
}