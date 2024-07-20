class_name RoomPanelBed extends NinePatchRect

@export var bed : Bed
@export var pic : TextureRect

func init(bed : Bed):
	self.bed = bed
	pic.texture = bed.icon
