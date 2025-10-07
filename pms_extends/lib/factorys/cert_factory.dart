import 'dart:io';
import 'dart:typed_data';

class CertFactory {
  static SecurityContext? create(ByteData certData) {
    if (certData.lengthInBytes == 0) return null;
    final context = SecurityContext(withTrustedRoots: true);
    context.setTrustedCertificatesBytes(certData.buffer.asUint8List());
    return context;
  }
}