
Function.prototype.bind = function(target){
	var fun = this;
	return function(){
		fun.apply(target, arguments);
	};
}


window.notes = {};
(function(){
	var db = null;
	var tName = 'notes'; 
	var _cFun = null;  
	
	notes.init = function(){
		

		var dbSize = 5 * 1024 * 1024;
		db = openDatabase('Daily', '1.0', 'HTML5 Daily Book', dbSize);
		db.transaction(function(tx) {
			tx.executeSql('CREATE TABLE IF NOT EXISTS ' + 
						  tName +'(date INTEGER PRIMARY KEY ASC, content TEXT, added_on DATETIME)', []);
		});
	};

	notes.getNote = function(date, cFun){ 
		_cFun = cFun;
		if(!cFun){
			alert('cFun');
			return;
		}
		
		db.transaction(function(tx) {
			var sql = 'SELECT * FROM '+ tName +' WHERE date='+ date;
			//console.log(sql);
			tx.executeSql(sql, [], _t.onFind.bind(_t), _t.onError.bind(_t));
		});
		
	};
	notes.setNote = function(date, content, cFun){ 
		_cFun = cFun;
		if(!cFun){
			alert('cFun');
			return;
		}
		//function _onError(tx, e){
		//	update(date, content);
		//}
		console.log(content);
		window.C = content;
		data = content.toDataURL("image/png", "");
		//console.log(data);
		//data = encodeURIComponent(data);
		db.transaction(function(tx){
			tx.executeSql('INSERT INTO '+ tName +'(date, content) VALUES (?,?)',
							[date, data],
						_t.onSet.bind(_t),
						_t.onError.bind(_t));
						//_onError);
		});

		return;
	};
	function update(date, content){
		db.transaction(function(tx){
			console.log('this is update');
			//tx.executeSql('UPDATE '+ tName +' SET content='+ content +' WHERE date='+ date, 
			var sql = 'UPDATE '+ tName +'(content) VALUES(?) WHERE date='+ date;
			console.log(sql);
			tx.executeSql(sql, 
						[content],
						_t.onSet.bind(_t),
						_t.onError.bind(_t)
					);
		});
	}
		notes.clear = function(){
		db.transaction(function(tx){
			var sql = 'delete from notes where 1';
			tx.executeSql(sql);
				//_onError);
		});
	}
	
	var _t = {};
	_t.onError = function(tx, e) {
	  console.log('Something unexpected happened: ' + e.message );
	  _cFun(false);
	};
	_t.onFind = function(tx, r){
		console.log(r);
		window.R = r;
		if(!r.rows.length){
			_cFun(false);
			return;
		}
		var o = r.rows.item(0);
		var canvas = new Image();
		canvas.src = o.content;
		_cFun(canvas);  //todo 
	};
	_t.onSet = function(tx, r){
		console.log(r);
		_cFun(r.insertId);
	};
})();
