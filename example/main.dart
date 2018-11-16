import 'package:maybe/maybe.dart';

class Update {
  final Maybe<String> title;
  final Maybe<String> description;
  Update({this.title, this.description});
}

void main(args) {
  // Update for the title, none for description
  var update =
      Update(title: Maybe.some("new title"), description: Maybe.nothing());

  // No update for title
  when(update.title, some: (v) {
    print("Updating title $v");
  });

  // if is also possible
  if(isNothing(update.title)) {
    print("No description");
  }

  // Fallback value
  print(some(update.description, "default description"));
}
