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
      id: json['idCategory'] as String,
      title: json['strCategory'] as String,
      img: json['strCategoryThumb'] as String,
      short: json['strCategoryDescription'] as String,
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

  List<Object?> get props => [id, title, img, short];

  @override
  String toString() {
    return 'Product(id: $id, title: $title, img: $img, short: $short)';
  }
}
