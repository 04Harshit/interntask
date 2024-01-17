class ApiResponseHandler {
  static Map<String, dynamic> responseData(uriResponse) {
    Map<String, dynamic> response = Map<String, dynamic>();
    if (uriResponse.statusCode == 200 || uriResponse.statusCode == 201) {
      response["statusCode"] = 200;
      response["result"] = uriResponse.body;
      response["error"] = null;
    } else if (uriResponse.statusCode >= 400 && uriResponse.statusCode <= 500) {
      response["statusCode"] = uriResponse.statusCode;
      response["result"] = null;
      response["error"] = uriResponse.body;
    } else {
      response["statusoCode"] = uriResponse.statusCode;
      response["result"] = null;
      response["error"] = "Something went wrong";
    }

    return response;
  }

  static Map<String, dynamic> outputError() {
    Map<String, dynamic> response = Map<String, dynamic>();
    response["result"] = null;
    response["statusCode"] = 500;
    response["error"] = "Something went wrong";

    return response;
  }
}
