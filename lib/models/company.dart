class Company {
  String name;
  String type;
  String linkLogo;
  String pass;

  Company({
    this.linkLogo,
    this.name,
    this.type,
    this.pass,
  });

  factory Company.fromSnapshot(Map<String, String> snapshot) {
    return Company(
        linkLogo: snapshot["link_logo"],
        name: snapshot['name'],
        type: snapshot['type'],
        pass: snapshot['pass']);
  }
}
