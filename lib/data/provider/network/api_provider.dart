import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/src/media_type.dart' as m;
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/config/global_var.dart';
import 'package:moview_explorer_app/app/utils/utils.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'api_endpoint.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);

  final _client = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      followRedirects: true,
      maxRedirects: 3,
      connectTimeout: Duration(seconds: 120),

      receiveTimeout: Duration(seconds: 120)));

  APIProvider() {
    _client.interceptors.add(DioLogInterceptor());
  }


  Future baseGetAPI(url,query, auth, context, {successMsg, loading, bool direct = false, String? fullUrl}) async {
   log(fullUrl ?? (ApiEndPoints.baseUrl + url));
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log(
            "[APIProvider.baseGetAPI Authed] called with : ${Globals.authToken}");
        response = await _client.get(fullUrl ?? (ApiEndPoints.baseUrl + url),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
               'authorization': "Bearer ${Globals.authToken}"
            }),
          // queryParameters: query as Map<String, dynamic>
        );
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("[APIProvider.baseGetAPI unAuthed] called");
        response = await _client.get(fullUrl ?? (ApiEndPoints.baseUrl + url),
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}),);
      }
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      if (e.response != null) {
        return _returnResponse(e.response!);
      } else {
        return "No internet connection";
      }
    }
  }

  Future checkStatusAPI(url, auth, context,
      {successMsg, loading, bool direct = false, String? fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log(
            "[APIProvider.baseGetAPI Authed] called with : ${Globals.authToken}");
        response = await _client.get(fullUrl ?? (ApiEndPoints.baseUrl + url),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("[APIProvider.baseGetAPI unAuthed] called");
        response = await _client.get(fullUrl ?? (ApiEndPoints.baseUrl + url),
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return response.statusCode;
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response?.statusCode);
      }
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return e.response?.statusCode;
        } else {
          return e.response?.statusCode;
        }
      } else {
        return e.response?.statusCode;
      }
    }
  }

  Future basePostAPI(url, body, auth, context, {successMsg, loading, bool direct = false, fullUrl}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);
    if (loading == true && loading != null) {
      dialog.show(
          indicatorColor: AppColors.primary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log(jsonEncode(body));
        log("auth true");
        log("auth token...${Globals.authToken}");
        response = await _client.post(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
               'authorization': "Bearer ${Globals.authToken}",
            }));
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("auth false");
        log(jsonEncode(body));
        response = await _client.post(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      dialog.hide();
      print(response);
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      dialog.hide();
      _returnResponse(e.response);
      // pr.close();
      // if (e.response?.data.runtimeType == String) {
      //   dialog.hide();
      //   // pr.close();
      //   if (e.response?.data.contains("limit")) {
      //     return null;
      //   } else {
      //     dialog.hide();
      //    // pr.close();
      //     // Utils().showBottomSheetWidget();
      //     return {"statusCode": 401};
      //   }
      // } else {
      //   dialog.hide();
      //
      //   // pr.close();
      //   // return e.response?.data;
      //   return _returnResponse(e.response);
      // }
    }
  }


  Future tokenPostApi(body, context, {successMsg, loading}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);
    if (loading == true && loading != null) {
      dialog.show(
          indicatorColor: AppColors.primary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }
    try {
      Response response;
        log(jsonEncode(body));
        response = await _client.post("https://api.sandbox.checkout.com/tokens",
            data: body,
            options: Options(headers: <String, String>{
              'authorization': "pk_sbox_2mhlxi24rr6fyjngblns6phbqmw",
            }));
      dialog.hide();
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      dialog.hide();
      // pr.close();
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        dialog.hide();
        // pr.close();
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          dialog.hide();
          // pr.close();
          // Utils().showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        dialog.hide();
        // pr.close();
        return e.response?.data;
      }
    }
  }

  Future basePutAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false, fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log(jsonEncode(body));
        log("auth true");
        response = await _client.patch(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("auth false");
        log(jsonEncode(body));
        response = await _client.put(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future baseDeleteAPI(url, body, auth, context, {successMsg, loading, bool direct = false}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

    if (loading == true && loading != null) {
      dialog.show(message: 'Loading...', type: SimpleFontelicoProgressDialogType.normal);
    }

    try {
      Response response;
      if (auth == null || auth == true) {
        log(ApiEndPoints.baseUrl + url);
        log(jsonEncode(body));
        log("auth true");
        response = await _client.delete(ApiEndPoints.baseUrl + url,
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        log(ApiEndPoints.baseUrl + url);
        log("auth false");
        log(jsonEncode(body));
        response = await _client.delete(ApiEndPoints.baseUrl + url,
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      dialog.hide();
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeOutException(null);
    } on SocketException {
      dialog.hide();
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      dialog.hide();
      _returnResponse(e.response);
      log(e.response?.data);
    }
  }

  Future baseMultiPartAPI(url, body, auth, context, File file,
      {successMsg,
      loading,
      bool direct = false,
      Function(int sent, int total)? progress}) async {
    String fileName = file.path.split("/").last;
    try {
      FormData? formData;
      _client.options.headers
          .addAll({"authorization": "Bearer ${Globals.authToken}"});
      Response response;
      formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType:
                m.MediaType('image', fileName.split(".").last.toLowerCase())),
      });
      response = await _client.post(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          log('$sent : $total');
          if (progress != null) {
            progress(sent, total);
          }
        },
      );

      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          // Utils.showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }



  Future baseMultiPartMedia(url, body, auth, context, File file,
      {successMsg,
        loading,
        bool direct = false,
        Function(int sent, int total)? progress}) async {
    String fileName = file.path.split("/").last;
    try {
      FormData? formData;
      _client.options.headers
          .addAll({"authorization": "Bearer ${Globals.authToken}"});
      Response response;
      formData = FormData.fromMap({
        "media": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType:
            m.MediaType('image', fileName.split(".").last.toLowerCase())),
      });
      response = await _client.post(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          log('$sent : $total');
          if (progress != null) {
            progress(sent, total);
          }
        },
      );

      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          // Utils.showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }











  Future baseMultiPartAPIGig(
      String url,
      Map<String, dynamic> body,
      bool auth,
      BuildContext? context,
      List<File> files, // Change from single File to List<File>
          {String? successMsg,
        bool loading = false,
        bool direct = false,
        Function(int sent, int total)? progress}) async {

    try {
      _client.options.headers.addAll({"authorization": "Bearer ${Globals.authToken}"});
      // Convert multiple files into MultipartFile
      List<MultipartFile> multipartFiles = [];
      for (var file in files) {
        String fileName = file.path.split("/").last;
        multipartFiles.add(await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: m.MediaType('image', fileName.split(".").last.toLowerCase()),
        ));
      }


      log('Multipart ----------- ${multipartFiles.toList()}');
      log('Body ----------- ${body}');


      FormData formData = FormData.fromMap({
        ...body, // Include additional fields
        "images": multipartFiles, // Send multiple images
      });

      log('formData ----------- ${formData.fields}');
      Response response = await _client.post(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          log('$sent : $total');
          progress?.call(sent, total);
        },
      );

      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log(e.response?.data.toString() ?? "Unknown Error");
      if (e.response?.data.runtimeType == String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return {"statusCode": 401};
      }
    }
  }



  Future baseMultiPartPatchAPIGig(
      String url,
      Map<String, dynamic> body,
      bool auth,
      BuildContext? context,
      List<File> files, // Change from single File to List<File>
          {String? successMsg,
        bool loading = false,
        bool direct = false,
        Function(int sent, int total)? progress}) async {

    try {
      _client.options.headers.addAll({"authorization": "Bearer ${Globals.authToken}"});
      // Convert multiple files into MultipartFile
      List<MultipartFile> multipartFiles = [];
      for (var file in files) {
        String fileName = file.path.split("/").last;
        multipartFiles.add(await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: m.MediaType('image', fileName.split(".").last.toLowerCase()),
        ));
      }


      log('Multipart ----------- ${multipartFiles.toList()}');
      log('Body ----------- ${body}');



      FormData formData = FormData.fromMap({
        ...body, // Include additional fields
        "images": multipartFiles, // Send multiple images
      });



      log('formData ----------- ${formData.fields}');
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          log('$sent : $total');
          progress?.call(sent, total);
        },
      );

      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log(e.response?.data.toString() ?? "Unknown Error");
      if (e.response?.data.runtimeType == String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return {"statusCode": 401};
      }
    }
  }





  Future baseMultipartPersonalImage(
      String url,
      Map<String, dynamic> body,
      File storeLogo,
      context,
      {
        Function(int sent, int total)? progress,
      }) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "identity_pic": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }




  Future baseMultipartBusinessLogoWithoutData(
      String url,
      Map<String, dynamic> body,
      File storeLogo,
      context,
      {
        Function(int sent, int total)? progress,
      }) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        "logo": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }



  Future baseMultipartBusinessLogoWithData(
      String url,
      Map<String, dynamic> body,
      File storeLogo,
      context,
      {
        Function(int sent, int total)? progress,
      }) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "logo": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }






  Future baseMultipartPersonalInfo(String url, Map<String, dynamic> body, File storeLogo, context, {Function(int sent, int total)? progress,}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "identity_pic": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }



  Future baseMultipartAgencyPersonalInfo(String url, Map<String, dynamic> body, File storeLogo, context, {Function(int sent, int total)? progress,}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "cover_image": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }







  Future baseMultipartPersonalIdentityPic(String url, Map<String, dynamic> body, File storeLogo, context, {Function(int sent, int total)? progress,}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        "identity_pic": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }





  Future baseMultipartPersonalCoverImage(String url, Map<String, dynamic> body, File storeLogo, context, {Function(int sent, int total)? progress,}) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        "cover_image": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }





  Future baseMultipartWithCertificateImage(
      String url,
      Map<String, dynamic> body,
      File storeLogo,
      context,
      {
        Function(int sent, int total)? progress,
      }) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "certificate_image": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      log("body: ${formData.fields}");
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }








  Future baseMultipartPersonalInfoPatch(
      String url,
      Map<String, dynamic> body,
      File storeLogo,
      context,
      {
        Function(int sent, int total)? progress,
      }) async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "avatar": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
            m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw SocketException("No Internet connection");
    } on DioError catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }

  dynamic _returnResponse(Response<dynamic>? response) {
    print('APIProvider._returnResponse');
    switch (response?.statusCode) {
      case 200:
        log("200");
        // print(response.data);
        return response?.data;
      case 201:
        log("201");
        // print(response.data);
        return response?.data;
      case 400:
        if(response?.data['error']!=null){
          Utils.showToast(message: response?.data['error']);
        }else{
          Utils.showToast(message: response?.data['data']['error']);
        }
        throw BadRequestException(response?.data.toString());
      case 401:
        // refreshToken();
        // _client.close();
        // token issue
        return response?.data;

        // throw BadRequestException(response?.data.toString());
      case 403:
        if(response?.data['error']!=null){
          Utils.showToast(message: response?.data['error']);
        }else{
          Utils.showToast(message: response?.data['data']['error']);
        }
        throw UnauthorisedException(response?.data.toString());
      case 404:
        print('APIProvider._returnResponse ${response?.data['data']['error']}');
        // if(response?.data['data']['error']!=null){
        //   Utils.showToast(message: response?.data['error']);
        // }else{
          Utils.showToast(message: response?.data['data']['error']);
        // }
        print('APIProvider._returnResponse');
        print(response?.data['data']);
        throw BadRequestException(response?.data['data'].toString());
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        log("default");
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response?.statusCode}');
    }
  }

// refreshToken() async {
















// }
}

class AppException implements Exception {
  final code;
   String? message;
  final details;

  AppException({this.code, this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
          code: "unauthorised",
          message: "Unauthorised",
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
