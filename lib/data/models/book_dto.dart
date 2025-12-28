import 'package:equatable/equatable.dart';
import 'package:my_app/features/home/domain/entity/book.dart';

class BookDto extends Equatable {
  const BookDto({
    required this.id,
    required this.title,
    required this.authors,
    this.subtitle,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.categories,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
    this.shelf,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) => BookDto(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String?,
    authors: (json['authors'] as List<dynamic>?)?.cast<String>() ?? [],
    publisher: json['publisher'] as String?,
    publishedDate: json['publishedDate'] as String?,
    description: json['description'] as String?,
    industryIdentifiers: (json['industryIdentifiers'] as List<dynamic>?)
        ?.map((e) => Map<String, dynamic>.from(e as Map))
        .toList(),
    readingModes: json['readingModes'] as Map<String, dynamic>?,
    pageCount: json['pageCount'] as int?,
    printType: json['printType'] as String?,
    categories: (json['categories'] as List<dynamic>?)?.cast<String>(),
    averageRating: (json['averageRating'] as num?)?.toDouble(),
    ratingsCount: json['ratingsCount'] as int?,
    maturityRating: json['maturityRating'] as String?,
    allowAnonLogging: json['allowAnonLogging'] as bool?,
    contentVersion: json['contentVersion'] as String?,
    panelizationSummary: json['panelizationSummary'] as Map<String, dynamic>?,
    imageLinks: json['imageLinks'] as Map<String, dynamic>?,
    language: json['language'] as String?,
    previewLink: json['previewLink'] as String?,
    infoLink: json['infoLink'] as String?,
    canonicalVolumeLink: json['canonicalVolumeLink'] as String?,
    shelf: json['shelf'] as String?,
  );

  static List<BookDto> listFromJson(Map<String, dynamic> json) {
    final list = json['books'] as List<dynamic>?;
    if (list == null) return [];
    return list.map((e) => BookDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  final String id;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final List<Map<String, dynamic>>? industryIdentifiers;
  final Map<String, dynamic>? readingModes;
  final int? pageCount;
  final String? printType;
  final List<String>? categories;
  final double? averageRating;
  final int? ratingsCount;
  final String? maturityRating;
  final bool? allowAnonLogging;
  final String? contentVersion;
  final Map<String, dynamic>? panelizationSummary;
  final Map<String, dynamic>? imageLinks;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;
  final String? shelf;
  
  Book toDomain() => Book(
    id: id,
    title: title,
    subtitle: subtitle,
    authors: authors,
    description: description,
    pageCount: pageCount,
    categories: categories,
    averageRating: averageRating,
    language: language,
    shelf: shelf,
    thumbnailUrl: imageLinks?['thumbnail'] as String?,
  );

  static List<Book> listToDomain(List<BookDto> dtos) {
    return dtos.map((dto) => dto.toDomain()).toList();
  }
  
  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    authors,
    publisher,
    publishedDate,
    description,
    industryIdentifiers,
    readingModes,
    pageCount,
    printType,
    categories,
    averageRating,
    ratingsCount,
    maturityRating,
    allowAnonLogging,
    contentVersion,
    panelizationSummary,
    imageLinks,
    language,
    previewLink,
    infoLink,
    canonicalVolumeLink,
    shelf,
  ];
}
