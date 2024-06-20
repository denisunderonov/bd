# В файле admin.py вашего приложения (например, myapp/admin.py)
from django.contrib import admin
from .models import Movies, Series, Animes, Recommendations, Users, Watched

admin.site.register(Movies)
admin.site.register(Series)
admin.site.register(Animes)
admin.site.register(Recommendations)
admin.site.register(Users)
admin.site.register(Watched)
