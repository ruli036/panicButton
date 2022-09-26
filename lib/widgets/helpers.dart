class TombolAdmin{
  static const String edit = 'Edit';
  static const String Hapus = 'Hapus';
  static const List<String> Pilih = <String>[
    edit,Hapus
  ];
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}