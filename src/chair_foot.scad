module chair_foot() {
  scale([1, 1, -1]) cylinder(h=5, d=20);
  difference() {
    cylinder(h=5, d=15.5);
    cylinder(h=30, d=12, center=true);
  }
}

chair_foot();
