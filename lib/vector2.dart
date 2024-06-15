

class Vector2 {

   Vector2(this.x, this.y);

   int x;
   int y;


  @override
  bool operator ==(Object other) {
    return other is Vector2 && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

}
