
# test accept header

## how to

1- open the db and start the server
2- open request.http in visual studio code ([visual studio code rest client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) must be installed)
3- send the request provided

## result

When doing request like

```http
GET http://localhost:8080/test
Accept: text/plain
```

and use in response

```4d
WEB SEND TEXT("hello")
````

we receive success http status code

```http
HTTP/1.1 200 OK
Connection: close
Content-Length: 1631
Content-Type: text/html; charset=UTF-8
Date: Fri, 19 Jun 2020 14:52:23 GMT
Expires: Fri, 19 Jun 2020 14:52:23 GMT
Server: 4D/18.4.0
Set-Cookie: 4DSID=DB36747FFC2941E68DA2FCA0CC290B14; Path=/; Max-Age=28800; HttpOnly; Version=1
```

**but** with html error body

```html
<!--
* This file is part of Wakanda software, licensed by 4D under
*  (i) the GNU General Public License version 3 (GNU GPL v3), or
*  (ii) the Affero General Public License version 3 (AGPL v3) or
*  (iii) a commercial license.
* This file remains the exclusive property of 4D and/or its licensors
* and is protected by national and international legislations.
* In any event, Licensee's compliance with the terms and conditions
* of the applicable license constitutes a prerequisite to any use of this file.
* Except as otherwise expressly stated in the applicable license,
* such license does not include any other license or rights on this file,
* 4D's and/or its licensors' trademarks and/or other proprietary rights.
* Consequently, no title, copyright or other proprietary rights
* other than those specified in the applicable license is granted.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>406 - Not Acceptable</title>
<style>
	body { margin: 0px; padding: 0px; font: 90% "Lucida Grande", Lucida, Verdana, sans-serif; }
	div#title { background-color: #2c4b79; padding: 15px 15px 15px 20px; margin: 0px; }
	div#message { padding: 20px; }
	div#details { padding: 10px; }
	h2 { color: #fff; font-size: 1.3em; margin: 0; padding: 0; }
	p { padding: 0px; margin: 0px; }
</style>
</head>
<body>
<div id="title">
<h2>406 - Not Acceptable</h2>
</div>
<div id="message">
<p></p>
</div>
<div id="details">
<code></code>
</div>
</body>
</html>
```

## workaround to send data

Always parse the header then use `Accept` header as mimetype (but there is also some others encoding to check)

```4d
ARRAY TEXT($names;0)
ARRAY TEXT($values;0)
WEB GET HTTP HEADER($names;$values)
$vlItem:=Find in array($names;"Accept")
If ($vlItem>0)
    WEB SEND TEXT("hello";$values{$vlItem})
Else
    WEB SEND TEXT("hello")
End if
```
