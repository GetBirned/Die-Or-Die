extends CanvasLayer

@onready var title_label = $TutorialSway/Panel/TitleLabel
@onready var body_label = $TutorialSway/Panel/BodyLabel

func set_content(title: String, body: String):
	title_label.text = title
	body_label.text = body
	
func _on_close_button_pressed() -> void:
	queue_free()
