import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eccemorce_route_project/features/login/data/data_source/remote/remote_ds.dart';

import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../../signup/data/models/ErrorModel.dart';
import '../../../../signup/data/models/UserModel.dart';

@Injectable(as: LogInRemoteDataSource)
class LogInRemoteDataSourceImpl implements LogInRemoteDataSource {
  ApiManager apiManager;

  LogInRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failures, UserModel>> login(
      String email, String password) async {
    try {
      Response response = await apiManager.postData(
          endPoint: EndPoints.signIn,
          body: {"email": email, "password": password});
      UserModel userModel = UserModel.fromJson(response.data);
      return Right(userModel);
    } on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);
      return (Left(RemoteFailures(errorModel.message ?? "")));
    }
  }
}
