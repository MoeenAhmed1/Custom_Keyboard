import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:custom_keyboard/model/data_model.dart';
class DataRepository{
  void addData(Data d)
  {
    final box=getBox();
    box.add(d);
  }
  Box<Data> getBox()
  {
    return Hive.box<Data>("DataBox");
  }
  Data? getData(int index)
  {
    final box=getBox();
    return box.getAt(index);
  }
  List<Data> getDatalist()
  {
    return getBox().values.toList().cast<Data>();
  }

}