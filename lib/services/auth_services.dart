import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_ecommerce_app_flutter/models/onboarding_model.dart';
import 'package:second_ecommerce_app_flutter/models/user_data.dart';
import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';

abstract class AuthServices {
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<bool> signUpWithEmailAndPassword(String name, String email, String password);
  Future<void> signOut();
  Future<bool> isLoggedIn();
  Future<User?> currentUser();
  Future<UserData?> getUser(String id);
  Future<void> updateUserData(String uid, UserData user);
  Future<List<OnboardingModel>> getOnbordingItems();
  Future<void> addOnbordingItem(OnboardingModel onboardingItem);
}

class AuthServicesImpl implements AuthServices {
  // Singleton Design Pattern
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirestoreService.instance;
  
  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  @override
  Future<bool> isLoggedIn() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signUpWithEmailAndPassword(String username, String email, String password) async {
    
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {

      final currentUserData = UserData(
      id: userCredential.user!.uid,
      email: email,
      username: username, 
      password: password,
      );
      
      await firestore.setData(
        path: ApiPaths.user(currentUserData.id),
        data: currentUserData.toMap(),
      );

      return true;
    } else {
      return false;
    }
    // User? user = userCredential.user;
    // if (user != null) {
    //   return true;
    // }
    // return false;
  }
  
  @override
  Future<User?> currentUser() {
    return Future.value(firebaseAuth.currentUser);
  }

  @override
  Future<UserData> getUser(String id) async =>
      await firestore.getDocument<UserData>(
        path: ApiPaths.user(id),
        builder: (data, documentId) => UserData.fromMap(data, documentId),
  );

  @override
  Future<void> updateUserData(String id, UserData user) async =>
    await firestore.setData(
        path: ApiPaths.user(id),
        data: user.toMap(),
      );

   @override
  Future<void> addOnbordingItem(OnboardingModel onboardingItem) async => 
    await firestore.setData(path: ApiPaths.onboarding(onboardingItem.id), data: onboardingItem.toMap());

  @override
  Future<List<OnboardingModel>> getOnbordingItems() async =>
      await firestore.getCollection<OnboardingModel>(
        path: ApiPaths.onboardings(),
        builder: (data, documentId) => OnboardingModel.fromMap(data, documentId),
  );


}