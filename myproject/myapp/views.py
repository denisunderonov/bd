# views.py

from django.http import JsonResponse, HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from .models import Movies, Series, Animes, Recommendations, Users, Watched
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
import json
import jwt
import bcrypt
import re



def getAllFilms(request):
    try:
        films = Movies.objects.values('id', 'rating', 'title', 'url')
        return JsonResponse({'status': True, 'result': list(films)})
    except Exception as e:
        print(f"Ошибка при получении фильмов: {e}")
        return HttpResponse("Ошибка на сервере", status=500)

def getAllSerials(request):
    try:
        serials = Series.objects.values('id', 'rating', 'title', 'url')
        return JsonResponse({'status': True, 'result': list(serials)})
    except Exception as e:
        print(f"Ошибка при получении сериалов: {e}")
        return HttpResponse("Ошибка на сервере", status=500)

def getAllAnime(request):
    try:
        animes = Animes.objects.values('id', 'rating', 'title', 'url')
        return JsonResponse({'status': True, 'result': list(animes)})
    except Exception as e:
        print(f"Ошибка при получении аниме: {e}")
        return HttpResponse("Ошибка на сервере", status=500)

def getFilm(request, id):
    try:
        film = Movies.objects.filter(id=id).values()
        if film:
            return JsonResponse({'status': True, 'result': list(film)})
        else:
            return HttpResponse("Фильм не найден", status=404)
    except Exception as e:
        print(f"Ошибка при получении фильма: {e}")
        return HttpResponse("Ошибка сервера", status=500)

def getSerial(request, id):
    try:
        serial = Series.objects.filter(id=id).values()
        if serial:
            return JsonResponse({'status': True, 'result': list(serial)})
        else:
            return HttpResponse("Сериал не найден", status=404)
    except Exception as e:
        print(f"Ошибка при получении сериала: {e}")
        return HttpResponse("Ошибка сервера", status=500)

def getAnime(request, id):
    try:
        anime = Animes.objects.filter(id=id).values()
        if anime:
            return JsonResponse({'status': True, 'result': list(anime)})
        else:
            return HttpResponse("Аниме не найдено", status=404)
    except Exception as e:
        print(f"Ошибка при получении аниме: {e}")
        return HttpResponse("Ошибка сервера", status=500)

from django.http import JsonResponse
from .models import Movies, Series, Animes

def getGenres(request):
    try:
        movies_genres = list(Movies.objects.values_list('genres', flat=True))
        series_genres = list(Series.objects.values_list('genres', flat=True))
        animes_genres = list(Animes.objects.values_list('genres', flat=True))

        # Удаление пробелов с начала и конца строк и символов \n
        def clean_genres(genres_list):
            cleaned_genres = []
            for genres in genres_list:
                cleaned_genres.extend(genre.strip() for genre in genres.split(','))
            return list(set(cleaned_genres))

        all_genres = {
            'films': clean_genres(movies_genres),
            'series': clean_genres(series_genres),
            'animes': clean_genres(animes_genres),
        }

        return JsonResponse(all_genres)
    except Exception as e:
        print(f"Ошибка при получении жанров: {e}")
        return HttpResponse("Ошибка сервера", status=500)


@csrf_exempt
def updateRecommendations(request):
    if request.method == 'POST':
        try:
            token = request.headers.get('Authorization').split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            data = json.loads(request.body.decode('utf-8'))
            series = data.get('series', [])
            animes = data.get('animes', [])
            films = data.get('films', [])

            recommendations, created = Recommendations.objects.update_or_create(
                user_id=user_id,
                defaults={
                    'series_rec': ', '.join(map(str, series)),
                    'animes_rec': ', '.join(map(str, animes)),
                    'films_rec': ', '.join(map(str, films))
                }
            )

            return JsonResponse({'message': 'Рекомендации успешно обновлены'})
        except Exception as e:
            print(f"Ошибка при обновлении рекомендаций: {e}")
            return HttpResponse("Ошибка при обновлении рекомендаций", status=500)
    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def getRecommendations(request):
    if request.method == 'GET':
        try:
            token = request.headers.get('Authorization').split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            recommendations = Recommendations.objects.filter(user_id=user_id).first()

            if not recommendations:
                return JsonResponse({'message': 'Рекомендации не найдены'}, status=404)

            series_rec = recommendations.series_rec.split(', ') if recommendations.series_rec else []
            animes_rec = recommendations.animes_rec.split(', ') if recommendations.animes_rec else []
            films_rec = recommendations.films_rec.split(', ') if recommendations.films_rec else []

            def clean_and_convert_genres(genre_string):
                if not genre_string:
                    return []
                return list(map(str.strip, genre_string.lower().split(',')))

            def get_all_content(content_model, genre_field):
                content_type = 'films' if content_model == Movies else 'serials' if content_model == Series else 'anime'
                contents = content_model.objects.values('id', 'title', 'rating', 'url', genre_field)
                for content in contents:
                    content['type'] = content_type
                return list(contents)

            recommended_movies = list(filter(lambda x: any(genre in clean_and_convert_genres(x['genres']) for genre in films_rec), get_all_content(Movies, 'genres')))
            recommended_series = list(filter(lambda x: any(genre in clean_and_convert_genres(x['genres']) for genre in series_rec), get_all_content(Series, 'genres')))
            recommended_animes = list(filter(lambda x: any(genre in clean_and_convert_genres(x['genres']) for genre in animes_rec), get_all_content(Animes, 'genres')))

            recommendations = {
                'movies': recommended_movies,
                'series': recommended_series,
                'animes': recommended_animes,
            }

            return JsonResponse(recommendations)
        except Exception as e:
            print(f"Ошибка при получении рекомендаций: {e}")
            return HttpResponse("Ошибка при получении рекомендаций", status=500)
    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def add_to_watch(request):
    if request.method == 'POST':
        try:
            token = request.headers.get('Authorization').split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            data = json.loads(request.body.decode('utf-8'))
            series_id = data.get('series_id')
            movie_id = data.get('movie_id')
            anime_id = data.get('anime_id')

            if series_id:
                if not Series.objects.filter(id=series_id).exists():
                    return JsonResponse({'message': 'Сериал с указанным id не существует'}, status=400)

            if movie_id:
                if not Movies.objects.filter(id=movie_id).exists():
                    return JsonResponse({'message': 'Фильм с указанным id не существует'}, status=400)

            if anime_id:
                if not Animes.objects.filter(id=anime_id).exists():
                    return JsonResponse({'message': 'Аниме с указанным id не существует'}, status=400)

            Watched.objects.create(
                user_id=user_id,
                series_id=series_id,
                movie_id=movie_id,
                anime_id=anime_id,
                watched_date=timezone.now()
            )

            return JsonResponse({'message': 'Запись добавлена в watched'})
        except Exception as e:
            print(f"Ошибка при добавлении записи в watched: {e}")
            return HttpResponse("Ошибка при добавлении записи в watched", status=500)
    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def remove_from_watch(request):
    if request.method == 'POST':
        try:
            token = request.headers.get('Authorization').split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            data = json.loads(request.body.decode('utf-8'))
            series_id = data.get('series_id')
            movie_id = data.get('movie_id')
            anime_id = data.get('anime_id')

            if series_id:
                if not Series.objects.filter(id=series_id).exists():
                    return JsonResponse({'message': 'Сериал с указанным id не существует'}, status=400)

            if movie_id:
                if not Movies.objects.filter(id=movie_id).exists():
                    return JsonResponse({'message': 'Фильм с указанным id не существует'}, status=400)

            if anime_id:
                if not Animes.objects.filter(id=anime_id).exists():
                    return JsonResponse({'message': 'Аниме с указанным id не существует'}, status=400)

            Watched.objects.filter(
                user_id=user_id,
                series_id=series_id,
                movie_id=movie_id,
                anime_id=anime_id,
            ).delete()

            return JsonResponse({'message': 'Запись удалена из watched'})
        except Exception as e:
            print(f"Ошибка при удалении записи из watched: {e}")
            return HttpResponse("Ошибка при удалении записи из watched", status=500)
    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def is_watched(request, type, id):
    if request.method == 'GET':
        try:
            token = request.headers.get('Authorization').split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            if type == 'series':
                content = Series.objects.filter(id=id).first()
            elif type == 'films':
                content = Movies.objects.filter(id=id).first()
            elif type == 'anime':
                content = Animes.objects.filter(id=id).first()
            else:
                return JsonResponse({'message': 'Некорректный тип контента'}, status=400)

            if not content:
                return JsonResponse({'message': f'{type.capitalize()} с указанным id не существует'}, status=400)

            is_watched = Watched.objects.filter(
                user_id=user_id,
                series_id=id if type == 'series' else None,
                movie_id=id if type == 'films' else None,
                anime_id=id if type == 'anime' else None,
            ).exists()

            return JsonResponse({'is_watched': is_watched})
        except Exception as e:
            print(f"Ошибка при проверке просмотра: {e}")
            return HttpResponse("Ошибка при проверке просмотра", status=500)
    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def get_watched(request):
    if request.method == 'GET':
        try:
            # Получаем токен из заголовка Authorization
            authorization_header = request.headers.get('Authorization')
            if not authorization_header:
                return JsonResponse({'message': 'Ошибка: Токен отсутствует'}, status=401)

            token = authorization_header.split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            watched_list = []

            # Получаем все записи о просмотренных элементах для пользователя
            watched_items = Watched.objects.filter(user_id=user_id)

            for item in watched_items:
                watched_item = {}

                # Если элемент является сериалом
                if item.series_id:
                    series = Series.objects.filter(id=item.series_id).values('id', 'title', 'rating', 'url').first()
                    if series:
                        watched_item = {
                            'id': series['id'],
                            'type': 'serials',
                            'title': series['title'],
                            'rating': series['rating'],
                            'url': series['url'],
                        }
                        watched_list.append(watched_item)

                # Если элемент является фильмом
                if item.movie_id:
                    movie = Movies.objects.filter(id=item.movie_id).values('id', 'title', 'rating', 'url').first()
                    if movie:
                        watched_item = {
                            'id': movie['id'],
                            'type': 'films',
                            'title': movie['title'],
                            'rating': movie['rating'],
                            'url': movie['url'],
                        }
                        watched_list.append(watched_item)

                # Если элемент является аниме
                if item.anime_id:
                    anime = Animes.objects.filter(id=item.anime_id).values('id', 'title', 'rating', 'url').first()
                    if anime:
                        watched_item = {
                            'id': anime['id'],
                            'type': 'anime',
                            'title': anime['title'],
                            'rating': anime['rating'],
                            'url': anime['url'],
                        }
                        watched_list.append(watched_item)

            return JsonResponse({'result': watched_list})

        except jwt.ExpiredSignatureError:
            return JsonResponse({'message': 'Ошибка: Срок действия токена истек'}, status=401)

        except jwt.InvalidTokenError:
            return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

        except Exception as e:
            print(f"Ошибка при получении просмотренного: {e}")
            return HttpResponse("Ошибка при получении просмотренного", status=500)

    else:
        return HttpResponse("Метод не поддерживается", status=405)
    
@csrf_exempt
def check_if_watched(request, route, id):
    if request.method == 'GET':
        try:
            token = request.headers.get('Authorization').split()[1]
            decoded_token = jwt.decode(token, 'secretTOKENMAN', algorithms=['HS256'])
            user_id = decoded_token['id']

            if not user_id:
                return JsonResponse({'message': 'Ошибка: Неверный токен'}, status=401)

            if route not in ['films', 'series', 'anime']:
                return JsonResponse({'message': 'Некорректный маршрут'}, status=400)

            watched = False

            if route == 'films':
                watched = Watched.objects.filter(user_id=user_id, movie_id=id).exists()
            elif route == 'series':
                watched = Watched.objects.filter(user_id=user_id, series_id=id).exists()
            elif route == 'anime':
                watched = Watched.objects.filter(user_id=user_id, anime_id=id).exists()

            return JsonResponse({'isWatched': watched})

        except Exception as e:
            print(f"Ошибка при проверке просмотра: {e}")
            return HttpResponse("Ошибка при проверке просмотра", status=500)

    else:
        return HttpResponse("Метод не поддерживается", status=405)


# views.py
@csrf_exempt
def register(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            login = data.get('login')
            email = data.get('email')
            password = data.get('password')

            # Проверка пароля на минимальную длину и отсутствие состоящего только из цифр
            if len(password) < 3 or password.isdigit():
                return JsonResponse({
                    'status': False,
                    'error': 'Пароль должен быть минимум 3 символа длиной и содержать буквы и цифры'
                }, status=400)

            # Хеширование пароля с использованием bcrypt
            salt = bcrypt.gensalt(10)
            password_hash = bcrypt.hashpw(password.encode('utf-8'), salt)

            # Создание пользователя
            user = Users.objects.create(
                login=login,
                email=email,
                password_hash=password_hash.decode('utf-8')
            )

            # Создание JWT токена для пользователя
            token = jwt.encode({'id': user.id}, 'secretTOKENMAN', algorithm='HS256').decode('utf-8')

            return JsonResponse({
                'status': True,
                'user': {
                    'id': user.id,
                    'login': user.login,
                    'email': user.email
                },
                'token': token
            })

        except Exception as e:
            print(f"Ошибка при регистрации: {e}")
            return HttpResponse("Ошибка на сервере", status=500)

    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def login(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            login = data.get('login')
            password = data.get('password')

            user = Users.objects.filter(login=login).first()

            if not user:
                return JsonResponse({'message': 'Пользователь не найден'}, status=404)

            if bcrypt.checkpw(password.encode('utf-8'), user.password_hash.encode('utf-8')):
                token = jwt.encode({'id': user.id}, 'secretTOKENMAN', algorithm='HS256').decode('utf-8')
                return JsonResponse({
                    'status': True,
                    'user': {
                        'id': user.id,
                        'login': user.login,
                        'email': user.email
                    },
                    'token': token
                })
            else:
                return JsonResponse({'message': 'Неверный логин или пароль'}, status=400)

        except Exception as e:
            print(f"Ошибка при входе: {e}")
            return HttpResponse("Ошибка на сервере", status=500)

    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt
def delete_acc(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            user_id = data.get('userId')

            user = Users.objects.filter(id=user_id).first()

            if not user:
                return JsonResponse({'error': 'Пользователь не найден'}, status=404)

            user.delete()

            return JsonResponse({'message': 'Аккаунт успешно удален'})

        except Exception as e:
            print(f"Ошибка при удалении аккаунта: {e}")
            return HttpResponse("Ошибка на сервере", status=500)

    else:
        return HttpResponse("Метод не поддерживается", status=405)

@csrf_exempt


def change_password(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            user_id = data.get('userId')
            new_password = data.get('newPassword')

            # Проверка пароля на допустимые символы
            if len(new_password) < 3:
                return JsonResponse({
                    'error': 'Пароль должен быть минимум 3 символа длиной'
                }, status=400)

            user = Users.objects.filter(id=user_id).first()

            if not user:
                return JsonResponse({'error': 'Пользователь не найден'}, status=404)

            # Генерация соли и хеширование пароля
            salt = bcrypt.gensalt(10)
            hashed_password = bcrypt.hashpw(new_password.encode('utf-8'), salt)

            # Обновление пароля пользователя
            user.password_hash = hashed_password.decode('utf-8')  # Поле password_hash должно существовать в вашей модели
            user.save()

            return JsonResponse({'message': 'Пароль успешно изменен'})

        except Exception as e:
            print(f"Ошибка при изменении пароля: {e}")
            return HttpResponse("Ошибка на сервере", status=500)

    else:
        return HttpResponse("Метод не поддерживается", status=405)