class_name DamageData

var multiplier: float = 1.0
var amount: float
var source: Node

func _init(
	amount_: float,
	multiplier_: float = 1.0,
	source_: Node = null
) -> void:
	self.amount = amount_
	self.multiplier = multiplier_
	self.source = source_

func demage() -> float:
	return amount * multiplier
