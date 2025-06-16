import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_depi/core/class/statusrequest.dart';
import 'package:flutter_application_depi/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;
class Crud{
  Future<Either<Statusrequest,Map>> postdata(linkurl,data)async{
    try{
      if(await checkInternet()){
        var response=await http.post(Uri.parse(linkurl),body: data);
        if(response.statusCode==200 || response.statusCode==201){
          Map responsebody=jsonDecode(response.body);
          return right(responsebody);
        }else{
          return left(Statusrequest.serverfailure);
        }
      }else{
        return left(Statusrequest.offlinefailure);
      }
    }catch(_){
      return left(Statusrequest.serverException);
    }
  }
}