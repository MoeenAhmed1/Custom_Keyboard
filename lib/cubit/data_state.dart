part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}
class DataLoading extends DataState{}
class DataLoaded extends DataState{

  final List<Data> datalist;


  DataLoaded(this.datalist);
  List<Data> get todoList=>datalist;
}
