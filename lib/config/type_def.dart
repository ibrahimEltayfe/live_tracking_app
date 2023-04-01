import 'package:dartz/dartz.dart';
import '../core/error_handling/failures.dart';

typedef FutureEither<T> = Future<Either<Failure,T>>;
