class ProfileResponse {
  ProfileResponse({
    required this.data,
  });

  User data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        data: User.fromJson(json["data"]),
      );
}

class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );
}

class ListResponse {
  ListResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Item> data;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Item>.from(json["data"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });

  int id;
  String name;
  int year;
  String color;
  String pantoneValue;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
      );
}

class Support {
  Support({
    required this.url,
    required this.text,
  });

  String url;
  String text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}

// ==================================

class BaseResponse {
  int code;
  String message;
  dynamic response;

  BaseResponse({
    required this.code,
    required this.message,
    this.response,
  });
}

class ErrorResponse {
  ErrorResponse({
    required this.code,
    required this.message,
    this.data,
  });

  String code;
  String message;
  dynamic data;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"],
      );
}

class ObjHolder {
  bool success;
  dynamic response;
  BaseResponse errresponse;

  ObjHolder(
    this.success,
    this.response,
    this.errresponse,
  );

  @override
  String toString() {
    if (!success)
      return "Not Success, Status : $success \n Message : $errresponse.message";
    return "Status : $success \n Message : $response";
  }
}
