import '../data/models/awaker.dart';

/// A utility class that handles image name and path generation for Awaker entities.
///
/// This class provides static methods to convert Awaker names into standardized
/// filenames and generate appropriate asset paths for different image types.
/// It ensures consistent naming conventions by replacing non-alphanumeric
/// characters with underscores.
///
/// Example:
/// ```dart
/// final awaker = Awaker(name: "Doll: Inferno");
/// final imageName = AwakerImageName.getImageName(awaker); // Returns "Doll_Inferno.png"
/// final cardPath = AwakerImageName.getCardPath(awaker);   // Returns "assets/images/card/Doll_Inferno.png"
/// ```
class AwakerImageName {

  /// Generates a standardized image filename for the given [awaker].
  ///
  /// This method takes an [Awaker] object and creates a PNG filename based on its name.
  /// All non-alphanumeric characters in the awaker's name are replaced with underscores
  /// to ensure the filename is valid across different file systems.
  ///
  /// Example:
  /// - For an awaker with name "Doll: Inferno", returns "Doll_Inferno.png"
  /// - For an awaker with name "Night@Star", returns "Night_Star.png"
  ///
  /// Returns a String representing the image filename with .png extension.
  static String getImageName(Awaker awaker) {
    String imageName = awaker.name.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_');

    return '$imageName.png';
  }
  
  /// Returns the file path to the card image asset for the given [awaker].
  ///
  /// @param awaker The Awaker entity to get the card image for
  /// @return A String representing the asset path to the awaker's card image in assets/images/card/
  static String getCardPath(Awaker awaker) {
    return 'assets/images/card/${getImageName(awaker)}';
  }

    /// Returns the file path to the splash art image asset for the given [awaker].
  ///
  /// @param awaker The Awaker entity to get the splash art image for
  /// @return A String representing the asset path to the awaker's splash art image in assets/images/card/
  static String getSplashArtPath(Awaker awaker) {
    return 'assets/images/splash_art/${getImageName(awaker)}';
  }
}
