
import 'common_model.dart';
import '../utils/images.dart';

List<CommonModel> ctdServices = getRenovateServices();

List<CommonModel> getRenovateServices() {
  List<CommonModel> ctdServices = [];
  ctdServices
      .add(CommonModel.withoutIcon("Medicina general", room, isSelected: true));
  ctdServices
      .add(CommonModel.withoutIcon("Psicología", kitchen, isSelected: false));
  ctdServices
      .add(CommonModel.withoutIcon("Psiquiatría", building, isSelected: false));
  ctdServices.add(
      CommonModel.withoutIcon("Trabajo social", office, isSelected: false));
  ctdServices.add(CommonModel.withoutIcon("Terapia ocupacional", office,
      isSelected: false));
  ctdServices.add(
      CommonModel.withoutIcon("Terapia espiritual", office, isSelected: false));
  return ctdServices;
}

class ServicesModel {
  int id;
  String name;
  String description;
  String multimedia;

  ServicesModel(this.id, this.name, this.description, this.multimedia);
}
