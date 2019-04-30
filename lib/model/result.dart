class Result {
  String shortDBName;
  String longDBName;
  String an;
  Abstract abstract;
  String bookEdition;
  List<Contributor> contributors;
  List<dynamic> docType;
  String identifier;
  List<dynamic> isbn;
  String isiType;
  String language;
  String publicationDate;
  List<dynamic> pubType;
  Title title;
  Result({
    this.shortDBName,
    this.longDBName,
    this.an,
    this.abstract,
    this.bookEdition,
    this.contributors,
    this.docType,
    this.identifier,
    this.isbn,
    this.isiType,
    this.language,
    this.publicationDate,
    this.pubType,
    this.title,
  });
  factory Result.fromJson(Map<dynamic, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return Result(
      // shortDBName: parsedJson['shortDBName'],
      // longDBName: parsedJson['longDBName'],
      // an: parsedJson['an'],
      abstract: parsedJson['abstract'] == null
          ? Abstract.fromJson(parsedJson['abstract'])
          : Abstract(abstract: ''),
      // bookEdition: parsedJson['bookEdition'],
      // contributors: (parsedJson['contributors'] ?? [])
      //     .map<Contributor>((contributor) => Contributor.fromJson(contributor))
      //     .toList(),
      // docType: parsedJson['docType'],
      // isiType: parsedJson['isiType'],
      // language: parsedJson['language'],
      // publicationDate: parsedJson['publicationDate'],
      // pubType: parsedJson['pubType'],
      title: Title.fromJson(parsedJson['title']),
    );
  }
  Map toJson() => {
        // 'shortDBName': shortDBName,
        // 'longDBName': longDBName,
        // 'an': an,
        'abstract': abstract.toJson(),
        // 'bookEdition': bookEdition,
        // 'contributors': contributors.map((contributor) => contributor.toJson()),
        // 'docType': docType,
        // 'identifier': identifier,
        // 'isbn': isbn,
        // 'isiType': isiType,
        // 'language': language,
        // 'publicationDate': publicationDate,
        // 'pubType': pubType,
        'title': title.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Abstract {
  String abstract;
  Abstract({this.abstract});
  factory Abstract.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return Abstract(abstract: parsedJson['value'] ?? '');
  }

  Abstract copyWith({String abstract}) {
    return Abstract(abstract: abstract ?? this.abstract);
  }

  Map toJson() => {
        'abstract': abstract,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Title {
  String value;
  String locale;
  Title({this.value, this.locale});
  factory Title.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return Title(
        value: parsedJson['value'] ?? '', locale: parsedJson['locale'] ?? '');
  }

  Title copyWith({String value, String local}) {
    return Title(value: value ?? this.value, locale: locale ?? this.locale);
  }

  Map toJson() => {
        'value': value,
        'locale': locale,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Contributor {
  String name;
  String type;
  Contributor({this.name, this.type});
  factory Contributor.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return Contributor(name: parsedJson['name'], type: parsedJson['type']);
  }
  Contributor copyWith({String name, String type}) {
    return Contributor(name: name ?? this.name, type: type ?? this.type);
  }

  Map toJson() => {
        'name': name,
        'type': type,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
