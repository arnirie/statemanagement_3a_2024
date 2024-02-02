import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:statemanagement_3a/models/product.dart';

class DbHelper {
  //constants
  static final dbName = 'products.db';
  static final dbVersion = 1;
  //products table
  static final tbProduct = 'product';
  static final prodCode = 'code';
  static final prodName = 'nameDesc';
  static final prodPrice = 'price';

  static Future<Database> openDb() async {
    //join databases path + dbname file
    var path = join(await getDatabasesPath(), dbName);
    var sql =
        'CREATE TABLE IF NOT EXISTS $tbProduct ($prodCode TEXT PRIMARY KEY, $prodName TEXT NOT NULL, $prodPrice DECIMAL(10,2))';
    var db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute(sql);
        print('table $tbProduct created');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion > oldVersion) {
          db.execute('DROP TABLE IF EXISTS $tbProduct');
          db.execute(sql);
        }
      },
    );
    return db;
  }

  static void insertProduct(Product product) async {
    final db = await openDb();
    db.insert(tbProduct, product.toMap());
    print('inserted');
  }

  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    final db = await openDb();
    return db.query(tbProduct);
  }
}
