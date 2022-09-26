import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/constants.dart';
import 'package:google_docs_clone/models/document_model.dart';
import 'package:google_docs_clone/models/error_model.dart';
import 'package:http/http.dart';

final documentRepositoryProvider = Provider<DocumentRepository>(
  (ref) => DocumentRepository(
    client: Client(),
  ),
);

class DocumentRepository {
  final Client _client;
  DocumentRepository({
    required Client client,
  }) : _client = client;

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel errorModel =
        ErrorModel(error: "Something wen't wrong", data: null);
    try {
      var res = await _client.post(
          Uri.parse(
            "$host/doc/create",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode(
            {
              'createdAt': DateTime.now().microsecondsSinceEpoch,
            },
          ));
      switch (res.statusCode) {
        case 200:
          errorModel = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          errorModel = ErrorModel(
            error: res.body,
            data: null,
          );
          break;
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }

  Future<ErrorModel> getDocument(String token) async {
    ErrorModel errorModel =
        ErrorModel(error: "Something wen't wrong", data: null);
    try {
      var res = await _client.get(
        Uri.parse(
          "$host/docs/me",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      switch (res.statusCode) {
        case 200:
          List<DocumentModel> documents = [];
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            documents.add(
                DocumentModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
          errorModel = ErrorModel(
            error: null,
            data: documents,
          );
          break;
        default:
          errorModel = ErrorModel(
            error: res.body,
            data: null,
          );
          break;
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }

  void updateTitle({
    required String token,
    required String id,
    required String title,
  }) async {
    await _client.post(
      Uri.parse(
        "$host/doc/title",
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        {
          'title': title,
          'id': id,
        },
      ),
    );
  }

  Future<ErrorModel> getDocumentById(String token, String id) async {
    ErrorModel errorModel =
        ErrorModel(error: "Something wen't wrong", data: null);
    try {
      var res = await _client.get(
        Uri.parse(
          "$host/docs/$id",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      switch (res.statusCode) {
        case 200:
          errorModel = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          throw "This Document doesn't exists, please create new one.";
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }
}
