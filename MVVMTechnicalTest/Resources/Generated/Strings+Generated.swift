// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Localizable.strings
  ///   MVVMTechnicalTest
  /// 
  ///   Created by Valentin Mille on 2/14/23.
  public static let devices = Strings.tr("Localizable", "devices", fallback: "Devices")
  public enum Device {
    /// Off
    public static let off = Strings.tr("Localizable", "device.off", fallback: "Off")
    /// On
    public static let on = Strings.tr("Localizable", "device.on", fallback: "On")
    public enum Heater {
      /// %@ at %@°
      public static func status(_ p1: Any, _ p2: Any) -> String {
        return Strings.tr("Localizable", "device.heater.status", String(describing: p1), String(describing: p2), fallback: "%@ at %@°")
      }
    }
    public enum Light {
      /// %@ at %@%%
      public static func status(_ p1: Any, _ p2: Any) -> String {
        return Strings.tr("Localizable", "device.light.status", String(describing: p1), String(describing: p2), fallback: "%@ at %@%%")
      }
    }
    public enum RollerShutter {
      /// Closed
      public static let closed = Strings.tr("Localizable", "device.rollerShutter.closed", fallback: "Closed")
      /// Opened
      public static let opened = Strings.tr("Localizable", "device.rollerShutter.opened", fallback: "Opened")
      /// Opened at %@%%
      public static func openedAt(_ p1: Any) -> String {
        return Strings.tr("Localizable", "device.rollerShutter.openedAt", String(describing: p1), fallback: "Opened at %@%%")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
