from django.db import models


class Record(models.Model):
    class Meta:
        db_table = "records"

    name = models.CharField(max_length=255)
    artist = models.CharField(max_length=255)
    year = models.IntegerField()
    number_of_discs = models.IntegerField()

    genre = models.ForeignKey('Genre', on_delete=models.CASCADE)


class Genre(models.Model):
    class Meta:
        db_table = "genres"

    name = models.CharField(max_length=255)
