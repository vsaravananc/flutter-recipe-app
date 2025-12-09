

import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';

abstract class DashboardRepo {
  Future<Either<FailerHandler,SuccessHandler>> getFiltetData();
  Future<Either<FailerHandler,SuccessHandler>> getCategoryData();
  Future<Either<FailerHandler,SuccessHandler>> getPopularData();

}