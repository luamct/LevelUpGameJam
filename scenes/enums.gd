class_name Enums

enum Attribute {
	STRENGTH = 0,
	SPEED = 1,
	AGILITY = 2,
	DEFENSE = 3,
	MORALE = 4,
	ATTACK = 5,
	DISCIPLINE = 6
}

static func as_string(attribute: Attribute) -> String:
	return Attribute.keys()[attribute]
