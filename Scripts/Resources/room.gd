class_name Room extends Resource

enum Star { One = 1, Two = 2, Three = 3, Four = 4, Five = 5 }
enum Floor { Ground = 0, First = 1, Second = 2 }
enum RoomType { Basic, Deluxe, Luxury }

@export var stars : Star
@export var floor : Floor
@export var type : RoomType
@export var beds : Array[Bed]