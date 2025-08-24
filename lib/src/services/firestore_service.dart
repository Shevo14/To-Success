import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db;
  const FirestoreService(this.db);

  Future<void> setDocument({required String path, required Map<String, dynamic> data, bool merge = true}) async {
    await db.doc(path).set(data, SetOptions(merge: merge));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({required String path}) async {
    return db.doc(path).get();
  }

  Future<DocumentReference<Map<String, dynamic>>> addDocument({required String collectionPath, required Map<String, dynamic> data}) async {
    return db.collection(collectionPath).add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream({required String collectionPath, Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> q)? queryBuilder}) {
    var q = db.collection(collectionPath).withConverter<Map<String, dynamic>>(
      fromFirestore: (snap, _) => snap.data() ?? <String, dynamic>{},
      toFirestore: (data, _) => data,
    );
    if (queryBuilder != null) {
      q = queryBuilder(q) as CollectionReference<Map<String, dynamic>>;
    }
    return q.snapshots();
  }
}