abstract class LibraryItem {
  final String id;
  final String title;
  final int year;
  bool isBorrowed;

  LibraryItem({
    required this.id,
    required this.title,
    required this.year,
    this.isBorrowed = false,
  });

  String get status => isBorrowed ? 'Borrowed' : 'Available';

  void displayInfo() {
    print('[$id] "$title" ($year) - $status');
  }
}

class Book extends LibraryItem {
  final String author;
  final String genre;
  final int pageCount;

  Book({
    required super.id,
    required super.title,
    required super.year,
    required this.author,
    required this.genre,
    required this.pageCount,
    super.isBorrowed,
  });

  @override
  void displayInfo() {
    print('[Book] $id: "$title" by $author | $genre, $pageCount pages ($year) - $status');
  }
}

class DVD extends LibraryItem {
  final String director;
  final int durationMins;

  DVD({
    required super.id,
    required super.title,
    required super.year,
    required this.director,
    required this.durationMins,
    super.isBorrowed,
  });

  @override
  void displayInfo() {
    print('[DVD] $id: "$title" dir. $director | ${durationMins}m ($year) - $status');
  }
}

class Magazine extends LibraryItem {
  final int issue;
  final String publisher;

  Magazine({
    required super.id,
    required super.title,
    required super.year,
    required this.issue,
    required this.publisher,
    super.isBorrowed,
  });

  @override
  void displayInfo() {
    print('[Magazine] $id: "$title" Issue #$issue ($publisher, $year) - $status');
  }
}

class LibraryMember {
  final String memberId;
  final String name;
  final List<LibraryItem> borrowedItems = [];

  LibraryMember(this.memberId, this.name);

  void printSummary() {
    print('$name ($memberId) - ${borrowedItems.length} item(s) checked out');
    for (var item in borrowedItems) {
      print('  - ${item.title}');
    }
  }
}

class Library {
  final String name;
  final List<LibraryItem> catalog = [];
  final Map<String, LibraryMember> members = {};

  Library(this.name);

  void addItem(LibraryItem item) {
    catalog.add(item);
  }

  void registerMember(LibraryMember member) {
    members[member.memberId] = member;
  }

  void showCatalog() {
    print('\n--- $name Catalog ---');
    if (catalog.isEmpty) {
      print('Catalog is currently empty.');
      return;
    }
    for (var item in catalog) {
      item.displayInfo();
    }
    print('');
  }

  List<LibraryItem> search(String query) {
    final q = query.toLowerCase();
    return catalog.where((item) => item.title.toLowerCase().contains(q)).toList();
  }

  bool checkoutItem(String memberId, String itemId) {
    final member = members[memberId];
    if (member == null) {
      print('Error: Member $memberId not found.');
      return false;
    }

    LibraryItem? item;
    for (var i in catalog) {
      if (i.id == itemId) {
        item = i;
        break;
      }
    }

    if (item == null) {
      print('Error: Item $itemId not in catalog.');
      return false;
    }

    if (item.isBorrowed) {
      print('Notice: "${item.title}" is already checked out.');
      return false;
    }

    item.isBorrowed = true;
    member.borrowedItems.add(item);
    print('${member.name} checked out "${item.title}".');
    return true;
  }

  bool returnItem(String memberId, String itemId) {
    final member = members[memberId];
    if (member == null) {
      print('Error: Member $memberId not found.');
      return false;
    }

    LibraryItem? item;
    for (var i in member.borrowedItems) {
      if (i.id == itemId) {
        item = i;
        break;
      }
    }

    if (item == null) {
      print('${member.name} does not have item $itemId checked out.');
      return false;
    }

    item.isBorrowed = false;
    member.borrowedItems.remove(item);
    print('${member.name} returned "${item.title}".');
    return true;
  }
}

void main() {
  final library = Library('Metropolitan Public Library');

  library.addItem(Book(
    id: 'B101',
    title: '1984',
    year: 1949,
    author: 'George Orwell',
    genre: 'Dystopian',
    pageCount: 328,
  ));

  library.addItem(Book(
    id: 'B102',
    title: 'Design Patterns',
    year: 1994,
    author: 'Erich Gamma et al.',
    genre: 'Computer Science',
    pageCount: 395,
  ));

  library.addItem(DVD(
    id: 'D201',
    title: 'Interstellar',
    year: 2014,
    director: 'Christopher Nolan',
    durationMins: 169,
  ));

  library.addItem(DVD(
    id: 'D202',
    title: 'Spider-Man: Into the Spider-Verse',
    year: 2018,
    director: 'Bob Persichetti',
    durationMins: 117,
  ));

  library.addItem(Magazine(
    id: 'M301',
    title: 'Wired Tech Weekly',
    year: 2024,
    issue: 112,
    publisher: 'Condé Nast',
  ));

  final sarah = LibraryMember('MEM-101', 'Sarah Jenkins');
  final david = LibraryMember('MEM-102', 'David Miller');
  final emma = LibraryMember('MEM-103', 'Emma Watson');

  library.registerMember(sarah);
  library.registerMember(david);
  library.registerMember(emma);

  library.showCatalog();

  print('Search results for "tech":');
  for (var item in library.search('tech')) {
    item.displayInfo();
  }
  print('');

  print('Checkout Transactions');
  library.checkoutItem('MEM-101', 'B101');
  library.checkoutItem('MEM-101', 'D201');
  library.checkoutItem('MEM-102', 'D201');
  library.checkoutItem('MEM-103', 'B102');

  print('Member Status');
  sarah.printSummary();
  david.printSummary();
  emma.printSummary();

  print('Returning Items');
  library.returnItem('MEM-101', 'D201');
  library.checkoutItem('MEM-102', 'D201');

  library.showCatalog();
}