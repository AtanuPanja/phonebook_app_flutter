bool validateName(String name) {
  // name field should not be empty
  return name.isNotEmpty;
}

bool validatePhone(String phone) {
  // phone must not be empty, and must have exactly 10 digits
  if (phone.length == 10) {
    int integerPhone = int.tryParse(phone) ?? -1;

    return (integerPhone != -1);
  }
  return false;
}
