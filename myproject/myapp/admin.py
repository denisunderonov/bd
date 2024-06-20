from django.contrib import admin
from .models import Animes, Movies, Recommendations, Series, Users, Watched

@admin.register(Animes)
class AnimesAdmin(admin.ModelAdmin):
    list_display = ('title', 'year', 'rating', 'seasons', 'get_genres')
    list_filter = ('year', 'rating')
    search_fields = ('title', 'genres')
    readonly_fields = ('url',)

    @admin.display(description='Genres')
    def get_genres(self, obj):
        return obj.genres

@admin.register(Movies)
class MoviesAdmin(admin.ModelAdmin):
    list_display = ('title', 'year', 'rating')
    list_filter = ('year', 'rating')
    search_fields = ('title', 'genres')
    readonly_fields = ('url',)

@admin.register(Recommendations)
class RecommendationsAdmin(admin.ModelAdmin):
    list_display = ('user', 'films_rec', 'series_rec', 'animes_rec')
    search_fields = ('user__login', 'films_rec', 'series_rec', 'animes_rec')

@admin.register(Series)
class SeriesAdmin(admin.ModelAdmin):
    list_display = ('title', 'year', 'rating', 'seasons', 'get_genres')
    list_filter = ('year', 'rating')
    search_fields = ('title', 'genres')
    readonly_fields = ('url',)

    @admin.display(description='Genres')
    def get_genres(self, obj):
        return obj.genres

@admin.register(Watched)
class WatchedAdmin(admin.ModelAdmin):
    list_display = ('user', 'series', 'movie', 'anime', 'watched_date')
    list_filter = ('watched_date',)
    search_fields = ('user__Login', 'series', 'movie', 'anime')
    raw_id_fields = ('user', 'series', 'movie', 'anime')

# Если вам нужны инлайн-редакторы для рекомендаций или других связанных моделей
class WatchedInline(admin.TabularInline):
    model = Watched
    raw_id_fields = ('series', 'movie', 'anime')

class RecommendationsInline(admin.TabularInline):
    model = Recommendations
    raw_id_fields = ('user',)

@admin.register(Users)
class UsersAdmin(admin.ModelAdmin):
    list_display = ('login', 'email', 'created_at', 'updated_at')
    list_filter = ('created_at', 'updated_at')
    search_fields = ('login', 'email')
    readonly_fields = ('password_hash',)
    date_hierarchy = 'created_at'
    list_display_links = ('login',)
    inlines = [WatchedInline, RecommendationsInline]
