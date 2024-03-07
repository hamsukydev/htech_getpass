class Request {
  String id;
  String requestStatus;
  String reason;
  String leaveDateAndTime;
  String returnDateAndTime;

  Request({
    required this.id,
    required this.requestStatus,
    required this.reason,
    required this.leaveDateAndTime,
    required this.returnDateAndTime,
  });
}
