class VideoModel {
  final String id;
  final String? title;
  final int? duration;
  final String style;
  final String? language;
  final String status;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? tokensUsed;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String? version;
  final List<String>? prompt;

  VideoModel({
    required this.id,
    required this.status,
    required this.style,
    this.title,
    this.duration,
    this.language,
    this.videoUrl,
    this.thumbnailUrl,
    this.tokensUsed,
    this.updatedAt,
    this.createdAt,
    this.version,
    this.prompt,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      status: map['status'] ?? 'UNKNOWN',
      style: map['style'] ?? 'DEFAULT',
      title: map['title'],
      duration: map['duration'],
      language: map['language'],
      videoUrl: map['videoUrl'],
      thumbnailUrl: map['thumbnailUrl'],
      tokensUsed: map['tokensUsed']?.toString(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      version: map['version'],
      prompt: map['prompt'] != null ? List<String>.from(map['prompt']) : null,
    );
  }
}
