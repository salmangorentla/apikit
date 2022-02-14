%dw 2.0
output application/java
// This DataWeave generates a MySQL Delete Query from your metadata for a particular entity

var remoteEntityName = attributes.entitySetName match {
	case remoteEntityName is String -> remoteEntityName
	else -> ""	
}

// Transform key-values pairs into something like myKey1 = 'myValue1' and myKey2 = 'myValue2'
var generateWhereClause = (attributes.odataRequestAttributes.entityTypeKeys mapObject ((value, key) -> '$key': "$key = $value")) pluck ((value, key, index) -> value ) joinBy  " AND "
---
"DELETE FROM $remoteEntityName WHERE $generateWhereClause"