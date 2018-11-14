from django.db import models


class Todo(models.Model):
    STATE_CHOICE = (
        ('todo', 'todo'),
        ('in-progress', 'in-progress'),
        ('done', 'done'),
    )

    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    state = models.CharField(choices=STATE_CHOICE, max_length=254)
    due_date = models.DateField()
    description = models.TextField()

    def __str__(self):
        return self.description[0:25]
