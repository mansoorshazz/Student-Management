import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class Students extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String age;

  @HiveField(2)
  String? place;

  @HiveField(3)
  late dynamic pic;

  Students(this.name, this.age, this.place, this.pic);
}
