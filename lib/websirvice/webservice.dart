import 'dart:convert';
import 'dart:developer';
import 'package:ecomerce/model/getcategory.dart';
import 'package:ecomerce/model/getofferproduct.dart';
import 'package:ecomerce/model/getorderdetails.dart';
import 'package:ecomerce/model/getuser.dart';
import 'package:http/http.dart' as http;

class Webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';

   final mainurl = 'http://bootcamp.cyralearnings.com/';

  Future<List<Getcategory>?> fetchCategory() async {
    try {
      final response = await http.get(Uri.parse(mainurl + 'getcategories.php'));
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<Getcategory>((json) => Getcategory.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed load category');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Getofferproducts>?> fetchproducts() async {
    final response =
        await http.get(Uri.parse(mainurl + 'view_offerproducts.php'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Getofferproducts>((json) => Getofferproducts.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed  to load album');
    }
  }

  Future<List<Getofferproducts>?> fetchCatProducts(int catid) async {
    log("catid ==" + catid.toString());
    final response = await http.post(
        Uri.parse(mainurl + 'get_category_products.php'),
        body: {'catid': catid.toString()});
    log("statuscode== " + response.statusCode.toString());
    if (response.statusCode == 200) {
      log("catid in string");
      log("response ==" + response.body.toString());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Getofferproducts>((json) => Getofferproducts.fromJson(json))
          .toList();
    } else {
      throw Exception('failed to load');
    }
  }

  Future<Getuser> fetchUser(String username) async {
    final response = await http.post(
        Uri.parse('http://bootcamp.cyralearnings.com/get_user.php'),
        body: {' username': username});
    if (response.statusCode == 200) {
      return Getuser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed load fetchUser');
    }
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    try {
      log("username ==" + username.toString());
      final response = await http.post(
          Uri.parse(mainurl + 'get_orderdetails.php'),
          body: {'username': username.toString()});
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed load Order details');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
