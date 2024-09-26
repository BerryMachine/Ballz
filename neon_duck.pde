String[] n = loadStrings("data1.txt");

for (int i = 0; i < n.length; i++) {
  String[] row = n[i].split("\t");
  for (String j : row) {
    println(j);
  }
}
