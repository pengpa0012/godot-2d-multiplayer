extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if "player" in body.name:
		body.queue_free()
	queue_free()
