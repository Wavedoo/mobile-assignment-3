class Food {
  final int id;
  final String name; 
  final int calories;
  static final columns = ["id", "name", "calories"]; 

  Food(this.id, this.name, this.calories);
  factory Food.fromMap(Map<dynamic, dynamic> data) { 
    return Food(
        data['id'],
        data['name'], 
        data['calories'], 
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id, 
    "name": name, 
    "calories": calories, 
  }; 
}