import 'package:bloc/bloc.dart';
import 'package:custom_keyboard/model/data_model.dart';
import 'package:custom_keyboard/repository/data_repository.dart';
import 'package:meta/meta.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(this.repo) : super(DataInitial());
  final DataRepository repo;
  void getDataList()
  {
    emit(DataLoading());
    final res=repo.getDatalist();
    emit(DataLoaded(res));
  }
  void addData(Data d)
  {
    emit(DataLoading());
    repo.addData(d);
  }
}
