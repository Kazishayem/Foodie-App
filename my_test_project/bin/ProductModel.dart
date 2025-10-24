import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String img;
  final String short;

  const Product({
    required this.id,
    required this.title,
    required this.img,
    required this.short,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['idCategory'] ?? '',
      title: json['strCategory'] ?? '',
      img: json['strCategoryThumb'] ?? '',
      short: json['strCategoryDescription'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': id,
      'strCategory': title,
      'strCategoryThumb': img,
      'strCategoryDescription': short,
    };
  }

  @override
  List<Object?> get props => [id, title, img, short];
}
