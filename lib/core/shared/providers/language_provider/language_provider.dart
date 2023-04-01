import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

import '../../../utils/shared_pref_helper.dart';
import '../../enums/app_languages.dart';
part 'language_state.dart';

final languageProvider = StateNotifierProvider<LanguageProvider,LanguageState>(
  (ref){
    return LanguageProvider();
  }
);

class LanguageProvider extends StateNotifier<LanguageState> {
  LanguageProvider() : super(LanguageInitial());

  AppLanguages? appLanguage;

  void init(){
    try{
      appLanguage = SharedPrefHelper.getLanguage();
      state = LanguageChanged();

    }catch(e){
      //todo:localize error message
      state = LanguageError('Could not get your preferred language');
    }

  }

  Future<void> changeLang(AppLanguages nextAppLanguage) async{

    state = const LanguageLoading();
    final setLanguage = await SharedPrefHelper.setData(value: nextAppLanguage.name, key: 'lang');

    if(setLanguage.isLeft()){
      state = const LanguageError('could not save your choice locally, you will have to select it again next time..');
    }

    appLanguage = nextAppLanguage;
    state = const LanguageChanged();

  }

}

