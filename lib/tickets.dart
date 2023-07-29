class Ticket {
  final String name;
  final String email;
  final String subject;
  final String message;

  //add ip, browser, device etc???

  const Ticket({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });
//I may add Date or Time Function
  static Ticket fromJson(json) => Ticket(
        name: json['name'],
        email: json['email'],
        subject: json['subject'],
        message: json['message'],
      );
}
