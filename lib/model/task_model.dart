class Taskmodel{
  final String? title;
  final String? datetime;
  final String? level;
  final bool isDone;
  final int? Taskid;
  Taskmodel({this.isDone = false ,this.Taskid, this.title, this.datetime, this.level});
  //take data
  factory Taskmodel.fromMap(Map<String,dynamic>map){
    return Taskmodel(
        Taskid: map['id'],
        title: map['title'],
        isDone: map['isDone'] == 0?false:true,
        level: map['level'],
        datetime: map['datetime']
    );
  }
  //send data
  Map<String,dynamic> toMap(){
    return {
      if (title!=null) 'title':title,
      if (datetime!=null)'datetime':datetime,
      if (level!=null)'level':level,
      'isDone':isDone?1:0,
      if (Taskid!=null)'id':Taskid
    };
  }
}