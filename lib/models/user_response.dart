class UserResponse {
  bool error;
  String message;
  User user;

  UserResponse({this.error, this.message, this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  int roleId;
  int subscriptionId;
  AccountType accountType;
  String name;
  String firstName;
  String lastName;
  Phone phone;
  String country;
  String businessEmail;
  String image;
  String email;
  String password;
  String passwordConfirmation;
  String emailVerifiedAt;
  Favorites favorites;
  int status;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String token;

  User(
      {this.id,
        this.roleId,
        this.subscriptionId,
        this.accountType,
        this.name,
        this.firstName,
        this.lastName,
        this.phone,
        this.country,
        this.businessEmail,
        this.image,
        this.email,
        this.password,
        this.passwordConfirmation,
        this.emailVerifiedAt,
        this.favorites,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    subscriptionId = json['subscription_id'];
    accountType = json['account_type'] != null
        ? new AccountType.fromJson(json['account_type'])
        : null;
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'] != null ? new Phone.fromJson(json['phone']) : null;
    country = json['country'];
    businessEmail = json['business_email'];
    image = json['image'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    emailVerifiedAt = json['email_verified_at'];
    favorites = json['favorites'] != null
        ? new Favorites.fromJson(json['favorites'])
        : null;
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['subscription_id'] = this.subscriptionId;
    if (this.accountType != null) {
      data['account_type'] = this.accountType.toJson();
    }
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    if (this.phone != null) {
      data['phone'] = this.phone.toJson();
    }
    data['country'] = this.country;
    data['business_email'] = this.businessEmail;
    data['image'] = this.image;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    if (this.favorites != null) {
      data['favorites'] = this.favorites.toJson();
    }
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}

class AccountType {
  bool customer;
  List<int> dalali;
  bool client;
  bool pro;

  AccountType({this.customer, this.dalali, this.client, this.pro});

  AccountType.fromJson(Map<String, dynamic> json) {
    customer = json['Customer'];
    dalali = json['Dalali'].cast<int>();
    client = json['Client'];
    pro = json['Pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Customer'] = this.customer;
    data['Dalali'] = this.dalali;
    data['Client'] = this.client;
    data['Pro'] = this.pro;
    return data;
  }
}

class Phone {
  String phone1;
  String phone2;

  Phone({this.phone1, this.phone2});

  Phone.fromJson(Map<String, dynamic> json) {
    phone1 = json['Phone1'];
    phone2 = json['Phone2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Phone1'] = this.phone1;
    data['Phone2'] = this.phone2;
    return data;
  }
}

class Favorites {
  List<int> favoriteList;

  Favorites({this.favoriteList});

  Favorites.fromJson(Map<String, dynamic> json) {
    favoriteList = json['favorite_list'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favorite_list'] = this.favoriteList;
    return data;
  }
}
