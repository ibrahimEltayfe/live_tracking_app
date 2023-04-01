import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userTypeProvider = StateProvider<UserType>((ref) {
  return UserType.tracker;
});
