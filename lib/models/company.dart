class Company {
  String name;
  String type;
  String linkLogo;

  Company({
    this.linkLogo,
    this.name,
    this.type,
  });

  factory Company.fromSnapshot(Map<String, String> snapshot) {
    return Company(
        linkLogo: snapshot["link_logo"],
        name: snapshot['name'],
        type: snapshot['type']);
  }
}
