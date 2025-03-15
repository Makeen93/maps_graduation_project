abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId});
  Future<Map<String, dynamic>> getData(
      {required String path, required String documnetId});
  Future<bool> checkIfDataExist(
      {required String path, required String documnetId});
}
