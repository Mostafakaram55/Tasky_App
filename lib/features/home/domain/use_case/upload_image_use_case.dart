
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/home_repository.dart';

class UploadImageUseCase extends UseCase<String,File>{
  HomeRepository homeRepository;
  UploadImageUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, String>> call([File? image])async{
    return await homeRepository.uploadImage(image: image!);
  }

}
