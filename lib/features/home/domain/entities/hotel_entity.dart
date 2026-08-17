class HotelEntity {
  const HotelEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.discount,
    required this.description,
    required this.images,
    required this.cityName,
    required this.phone,
    required this.email,
    required this.website,
    required this.facebook,
    required this.instagram,
    required this.latitude,
    required this.longitude,
    this.mainImg,
  });
  final int id;
  final String name;
  final String address;
  final double rating;
  final double discount;
  final String description;
  final String? mainImg;
  final List<String> images;
  final String cityName;
  final String phone;
  final String email;
  final String website;
  final String facebook;
  final String instagram;
  final double latitude;
  final double longitude;
}
