class AnnouncementModel {
  final String id;
  final String imgUrl;

  AnnouncementModel({required this.id, required this.imgUrl});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});

    return result;
  }

  factory AnnouncementModel.fromMap(
    Map<String, dynamic> map, String documentId) {

    return AnnouncementModel(
      id: documentId,
      imgUrl: map['imgUrl'] ?? '',
    );
  }
}

List<AnnouncementModel> dummyAnnouncements = [
  AnnouncementModel(
    id: 'B3x0wv7dMGT7slvUHbSV',
    imgUrl:
        'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg',
  ),
  AnnouncementModel(
    id: 'GHLipipb4u1QiCmC1POE',
    imgUrl:
        'https://edit.org/photos/img/blog/mbp-template-banner-online-store-free.jpg-840.jpg',
  ),
  AnnouncementModel(
    id: 'yl6JSh2cYLmpgSepJS6M',
    imgUrl:
        'https://casalsonline.es/wp-content/uploads/2018/12/CASALS-ONLINE-18-DICIEMBRE.png',
  ),
  AnnouncementModel(
    id: 'VVmXSLKRoC59xFECNKd5',
    imgUrl:
        'https://e0.pxfuel.com/wallpapers/606/84/desktop-wallpaper-ecommerce-website-design-company-noida-e-commerce-banner-design-e-commerce.jpg',
  ),
];