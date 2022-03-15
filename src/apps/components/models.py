from django.db import models


class Category(models.Model):
    title = models.CharField(max_length=100)

    def __str__(self):
        return self.title


class Component(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField()
    category = models.ForeignKey(
        Category,
        related_name="categories",
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.title
