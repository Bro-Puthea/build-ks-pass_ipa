class AppExceptions implements Exception{
  AppExceptions([this._message, this._prefix]);
  final _message;
  final _prefix;
  @override
  String toString(){
    return "$_message";
  }
}

//If we can't communicate with the network then this will throw ann exception after a certain time
class FetchDataException extends AppExceptions{
  //FetchDataException({String? message}) : super(message, "Error During Communication");
  FetchDataException({String? message}) : super(message, "Something went wrong.");
}

//If the BaseUrl is wrong and if the api is not available
class BadRequestException extends AppExceptions{
  BadRequestException({String? message}) : super(message, "Invalid Request");
}

//While doing signup/ login we get a token which validate that user has this app access/ data access
class UnAuthorizedException extends AppExceptions{
  UnAuthorizedException({String? message}) : super(message, "Unauthorized request");
}

class InvalidInputException extends AppExceptions{
  InvalidInputException({String? message}) : super(message, "Invalid Input");
}