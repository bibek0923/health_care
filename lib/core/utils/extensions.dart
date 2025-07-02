extension ImagePathExtensions on String {
  /// Converts the string to a PNG image path.
  String get toPng => 'assets/images/$this.png';
  String get fruitToPng => 'assets/fruits/$this.png';
  String get animalToPng => 'assets/animals/$this.png';

  /// Converts the string to a JPG image path.
  String get toJpg => 'assets/images/$this.jpg';

  /// Converts the string to a JPEG image path.
  String get toJpeg => 'assets/images/$this.jpeg';

  /// Converts the string to a GIF image path.
  String get toGif => 'assets/images/$this.gif';

}
