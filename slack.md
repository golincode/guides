Mass delete all files on slack
==============================

Run this code from your Chrome console. You may need to generate a new access token. Deletes 100 files at a time.


```
// You may have to update this
var token = '';


var xmlHttp = null;
var url = 'https://slack.com/api/files.list?token=' + token + '&count=100';

xmlHttp = new XMLHttpRequest();
xmlHttp.open( "GET", url, false );
xmlHttp.send( null );

var response =  xmlHttp.responseText;

response = JSON.parse(response);

if ( response.ok != true )
{
	console.log( response );
}

var filesDeleted = 0;

response.files.forEach(function(file) {

	var xmlHttp = null;
	url = 'https://architect.slack.com/api/files.delete?token=' + token + '&file=' + file.id;

	xmlHttp = new XMLHttpRequest();
	xmlHttp.open( "GET", url, false );
	xmlHttp.send( null );

	console.log( 'Deleted file #' + file.id );
	filesDeleted++;

});

console.log( 'Deleted ' + filesDeleted + ' files' );

```
