from django.urls import path, include

from . import views

urlpatterns = [
    path('/home', views.manager, name='home'),
    path('/pharmacy', views.pharmacy, name='pharmacy'),
    path('/pill', views.pill, name='pill'),
    path('/recipe', views.recipe, name='recipe'),
    path('/seller', views.seller, name='seller'),
    path('/storage', views.storage, name='storage')
]