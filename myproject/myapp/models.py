from django.db import models


class Animes(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    duration = models.IntegerField(blank=True, null=True)
    genres = models.CharField(max_length=255, blank=True, null=True)
    year = models.IntegerField(blank=True, null=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    url = models.TextField(blank=True, null=True)
    seasons = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'animes'


class Movies(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    duration = models.IntegerField(blank=True, null=True)
    genres = models.CharField(max_length=255, blank=True, null=True)
    year = models.IntegerField(blank=True, null=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    url = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'movies'


class Recommendations(models.Model):
    user = models.OneToOneField('Users', models.DO_NOTHING, primary_key=True)
    films_rec = models.TextField(blank=True, null=True)
    series_rec = models.TextField(blank=True, null=True)
    animes_rec = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'recommendations'


class Series(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    duration = models.IntegerField(blank=True, null=True)
    genres = models.CharField(max_length=255, blank=True, null=True)
    year = models.IntegerField(blank=True, null=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    url = models.TextField(blank=True, null=True)
    seasons = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'series'


class Users(models.Model):
    login = models.CharField(unique=True, max_length=50)
    email = models.CharField(unique=True, max_length=100)
    password_hash = models.CharField(max_length=255)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)
    favourites = models.JSONField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users'


class Watched(models.Model):
    user = models.ForeignKey(Users, models.DO_NOTHING)
    series = models.ForeignKey(Series, models.DO_NOTHING, blank=True, null=True)
    movie = models.ForeignKey(Movies, models.DO_NOTHING, blank=True, null=True)
    anime = models.ForeignKey(Animes, models.DO_NOTHING, blank=True, null=True)
    watched_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'watched'
