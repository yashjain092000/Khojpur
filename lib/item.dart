class Item {
  //String email;
  String place;
  String item;
  String date;
  String itemName;
  String image;
  String id;
  Item(this.place, this.item, this.date, this.itemName, this.image, this.id);
}

void deleteDuplicateItem(List<Item> c) {
  int m = c.length;
  for (int i = 0; i < m; i++) {
    for (int j = i + 1; j < m; j++) {
      if (c[i].date.compareTo(c[j].date) == 0) {
        c.removeAt(j);
      }
    }
  }
}
