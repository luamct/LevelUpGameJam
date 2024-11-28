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

enum Class {
	ANY = 0,
	FIGHTER = 1,
	BARD = 2,
	PALADIN = 3,
	SORCERER = 4,
	DRUID = 5,
	ROGUE = 6,
}

enum SpotType {
	PRODUCTION = 0, # Crops, dungeons and other spots that produce gold over time
	BUYING = 1,     # Tavern, shop and other spots that have goods (or adventurers) for a price
	TRAINING = 2    # Trainer and other spots that increase the adventurers level over time, for a price
}

static func attribute_string(attribute: Attribute) -> String:
	return Attribute.keys()[attribute]
	
static func class_string(class_: Class) -> String:
	return Class.keys()[class_]
	
