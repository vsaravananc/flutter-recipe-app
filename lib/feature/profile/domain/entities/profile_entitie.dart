import 'package:equatable/equatable.dart';

class ProfileEntitie extends Equatable {
  final String image;
  final String? name;
  const ProfileEntitie({required this.image, this.name});
  @override
  List<Object?> get props => [image, name];

  ProfileEntitie copyWith({String? image, String? name}) {
    return ProfileEntitie(
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }
  
}