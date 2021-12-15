import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class Data{
  @HiveField(1)
  final String string;
  Data(this.string);
}