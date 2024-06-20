from django.urls import path
from . import views

urlpatterns = [
    path('auth/register', views.register, name='register'),
    path('auth/login', views.login, name='login'),
    path('deleteacc', views.delete_acc, name='delete_acc'),  # Исправлено на deleteAcc
    path('films', views.getAllFilms, name='get_all_films'),  # Исправлено на getAllFilms
    path('films/<int:id>', views.getFilm, name='get_film'),  # Исправлено на getFilm
    path('serials', views.getAllSerials, name='get_all_serials'),  # Исправлено на getAllSerials
    path('serials/<int:id>', views.getSerial, name='get_serial'),  # Исправлено на getSerial
    path('anime', views.getAllAnime, name='get_all_anime'),  # Исправлено на getAllAnime
    path('anime/<int:id>', views.getAnime, name='get_anime'),  # Исправлено на getAnime
    path('genres', views.getGenres, name='get_genres'),  # Исправлено на getGenres
    path('getrecomends', views.getRecommendations, name='get_recommendations'),  # Исправлено на getRecommendations
    path('recomendations', views.updateRecommendations, name='update_recommendations'),  # Исправлено на updateRecommendations
    path('changepassword', views.change_password, name='change_password'),  # Исправлено на changePassword
    path('watched/add', views.add_to_watch, name='add_to_watch'),  # Исправлено на addToWatch
    path('watched/remove', views.remove_from_watch, name='remove_from_watch'),  # Исправлено на removeFromWatch
    path('watched/<str:type>/<int:id>', views.is_watched, name='is_watched'),  # Исправлено на isWatched
    path('watched', views.get_watched, name='get_watched'),  # Исправлено на getWatched
    path('watched/check/<str:route>/<int:id>', views.check_if_watched, name='check_if_watched'),  # Исправлено на checkIfWatched
]
