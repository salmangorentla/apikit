%dw 2.0
output application/java
 
var remoteEntityName = attributes.entitySetName match {
	case remoteEntityName is String -> remoteEntityName
	else -> ""	
}

var valuesFromPayload = {
	keys: payload pluck $$,
	values: payload pluck "'$'"
}

var columns = ( (valuesFromPayload.keys map "`$`" ) joinBy ", ") // myKey1, myKey2
var values = (valuesFromPayload.values joinBy ", ") // 'myValue1', 'myValue2'
---
"INSERT INTO $remoteEntityName ($columns) VALUES ($values)"