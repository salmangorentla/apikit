%dw 2.0
output application/java
// This DataWeave generates a MySQL Update Query from your metadata for a particular entity

var remoteEntityName = attributes.entitySetName match {
	case remoteEntityName is String -> remoteEntityName
	else -> ""	
}

// Transform key-values pairs into something like myKey1 = 'myValue1' and myKey2 = 'myValue2'
var generateWhereClause = (attributes.odataRequestAttributes.entityTypeKeys mapObject ((value, key) -> '$key': "$key = $value")) pluck ((value, key, index) -> value ) joinBy  " AND "

// Transform your payload (myKey1: myValue1, myKey2: myValue2) into something like myKey1 = 'myValue1', myKey2 = 'myValue2'
var sqlValues = (payload mapObject ((value, key) -> '$key': "$key = '$value'")) pluck ((value, key, index) -> value ) joinBy  ","
---
"UPDATE $remoteEntityName SET $sqlValues WHERE $generateWhereClause"