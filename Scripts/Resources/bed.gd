class_name Bed extends Resource

enum BedType { Single, Double, King, Queen, Futon }

@export var bed_type : BedType
@export var sleeps_count : int = 1
@export var icon : Texture2D