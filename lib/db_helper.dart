import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {

  var dialogueTable = 'note';
  var columnId = 'note_id';
  var columnTitle = 'note_title';
  var columnDesc = 'note_desc';


  var userdetailsTable = 'details';
  var userid = 'id';
  var username = 'name';
  var usermobile = 'mobileno';
  var useremail = 'emailadd';
  var userpassword = 'password';


  Future<Database> openDb() async {
    var directory = await getApplicationDocumentsDirectory();
    await directory.create(recursive: true);
    var path = directory.path + "note_db.db";
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          "create table $dialogueTable ($columnId integer primary key autoincrement,"
              "$columnTitle text, "
              "$columnDesc text)");

      db.execute(
          "create table $userdetailsTable ($userid integer primary key autoincrement,"
              "$usermobile text, "
              "$useremail text, "
              "$userpassword text, "
              "$username text)");
    });
  }


  Future <void> addData(String title, String desc) async {
    var myDB = await openDb();
    myDB.insert(dialogueTable, {columnTitle: title, columnDesc: desc});
  }


  Future<List<Map<String, dynamic>>> fetchData() async {
    var myDB = await openDb();
    return myDB.query(dialogueTable);
  }

  Future <void> delData(int id) async {
    var myDB = await openDb();
    await myDB.delete(
        dialogueTable, where: '$columnId = ?', whereArgs: [id.toString()]);
  }

  Future <void>  updateData(int id, String title, String desc) async{
    var myDB = await openDb();
    myDB.update(dialogueTable, {columnTitle: title, columnDesc: desc},
        where: '$columnId = ?', whereArgs: [id.toString()]);

  }






  //For user table

  void signupadddata(String name, String email, String mobile,
      String password) async {
    var myDB = await openDb();
    myDB.insert(userdetailsTable, {

      username: name,
      useremail: email,
      usermobile: mobile,
      userpassword: password,
    });
  }


  Future<bool> isemailexist(String email) async {
    var myDB = await openDb();
    var data = await myDB.query(
        userdetailsTable, where: '$useremail = ?', whereArgs: [email]);

    if (data.isNotEmpty) {
      return true; // user already exist so please login
    } else {
      return false; // user not exit you can signup and then login
    }
  }

  Future<bool> Authentication(String email, String password) async {
    var myDB = await openDb();
    var data = await myDB.query(
        userdetailsTable, where: '$useremail = ? and $userpassword = ?',
        whereArgs: [email, password]);
    if (data.isNotEmpty) {
      return true; // you can login to home page
    } else {
      return false; // not login show error box
    }
  }
}

