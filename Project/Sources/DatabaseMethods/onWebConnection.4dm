
If ($1="/manage")
	ARRAY TEXT:C222($names;0)
	ARRAY TEXT:C222($values;0)
	WEB GET HTTP HEADER:C697($names;$values)
	$vlItem:=Find in array:C230($names;"Accept")
	If ($vlItem>0)
		If ($values{$vlItem}="application/json")
			WEB SEND TEXT:C677("{\"message\": \"hello\"}";$values{$vlItem})
		Else 
			WEB SEND TEXT:C677("hello";$values{$vlItem})
		End if 
	Else 
		WEB SEND TEXT:C677("hello")
	End if 
Else 
	
	// standard simple code
	WEB SEND TEXT:C677("hello")
End if 
