import 'package:home_hub/models/follower_model.dart';
import 'network_utils.dart';

Future<List<FollowerModel>> getFollowers() async {
  var result = await handleResponse(
      await getRequest('https://api.github.com/users/octocat/followers'));

  Iterable list = result;
  return list.map((model) => FollowerModel.fromJson(model)).toList();
}

Future<List<ServicesModel>> getServices() async {
  var result = await handleResponse(await getRequest(
      'https://ef69-2800-370-12c-f120-6899-a545-e4e7-81c4.ngrok-free.app/detalle-secciones'));

  Iterable list = result;
  return list.map((model) => ServicesModel.fromJson(model)).toList();
}

/// POST method demo
Future createEmployee(Map req) async {
  return handleResponse(
      await postRequest('http://dummy.restapiexample.com/api/v1/create', req));
}
