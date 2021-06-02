import '../repositories/hotdogs_repository.dart';
import '../models/hotdog.dart';
import '../models/ingredient.dart';

class HomeController{

  HotDogsRepository hotDogsRepository;

  List<HotDog> get menu => hotDogsRepository.hotDogs;

  HomeController(){
    hotDogsRepository = HotDogsRepository();
  }


  }

