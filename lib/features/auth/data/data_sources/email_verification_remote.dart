import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error_handling/failures.dart';


class EmailVerificationRemote{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isEmailVerified() async{
    final user = _firebaseAuth.currentUser;

    if(user == null){
      throw NoUIDFailure();
    }

    await user.reload();
    return _firebaseAuth.currentUser!.emailVerified;
  }

  Future<void> sendEmailVerification() async{
    //send email verification
    final user = _firebaseAuth.currentUser;

    if(user == null){
      throw NoUIDFailure();
    }

    await user.sendEmailVerification();
  }


}