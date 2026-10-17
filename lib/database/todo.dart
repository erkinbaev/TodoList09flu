class Todo {
  int id;
  String title;
  bool isDone;
  String createAt;
  String deadline;

  Todo(
    {
      required this.id, 
      required this.title, 
      required this.isDone, 
      required this.createAt, 
      required this.deadline}
      );
}