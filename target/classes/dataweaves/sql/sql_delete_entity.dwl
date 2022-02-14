%dw 2.0
output application/java

var remoteEntityName = attributes.entitySetName match {
	case remoteEntityName is String -> remoteEntityName
	else -> ""	
}

var generateWhereClause = (attributes.odataRequestAttributes.entityTypeKeys mapObject ((value, key) -> '$key': "$key = $value")) pluck ((value, key, index) -> value ) joinBy  " AND "
---
"DELETE FROM $remoteEntityName WHERE $generateWhereClause"