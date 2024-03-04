class OnboardingModel{
  final String id;
  final String imgUrl;
  final String title;
  final String description;

 OnboardingModel({
  required this.id,
  required this.imgUrl,
  required this.title,
  required this.description,
 });

 Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'title': title});
    result.addAll({'description': description});

    return result;
  }

  factory OnboardingModel.fromMap(
    Map<String, dynamic> map, String documentId) {

    return OnboardingModel(
      id: documentId,
      imgUrl: map['imgUrl'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
  
}

List<OnboardingModel> dummyOnboardingItems = [
   OnboardingModel(
    id: '4DAzCT2jKJZtlh58V1NM',
    imgUrl: 'https://media.altphotos.com/cache/images/2017/04/24/17/752/content-handbag.jpg', 
    title: 'Various Collections Of The Latest Products', 
    description: 'Urna amit, suspendisse ullamcorper ac elit diam facilisis cursus vistibulum.'
  ),
  OnboardingModel(
    id: 'xnaFsvl3CvVpn11A41op',
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmTua3_zEJY6I7tcm_3G4KkN_9k5TvJNb-mXV1vO7cFJFkQi6ceiFiVmvy91xGDxEBrsY&usqp=CAU', 
    title: 'Complete Collection Of Colors And Sizes', 
    description: 'Urna amit, suspendisse ullamcorper ac elit diam facilisis cursus vistibulum.'
  ),
   OnboardingModel(
    id: 'xG2K6hAgNqqgpgzZxhV7',
    imgUrl: 'https://img.freepik.com/premium-photo/women-s-clothing-accessories-light-background-top-view_624178-1830.jpg?size=626&ext=jpg', 
    title: 'Find The Most Suitable Outfit For You', 
    description: 'Urna amit, suspendisse ullamcorper ac elit diam facilisis cursus vistibulum.'
  ),
];
