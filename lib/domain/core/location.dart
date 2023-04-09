import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String code;
  final String name;

  const Location({
    required this.code,
    required this.name,
  });
  @override
  List<Object?> get props => [code ?? "Country", name ?? "No"];
}
