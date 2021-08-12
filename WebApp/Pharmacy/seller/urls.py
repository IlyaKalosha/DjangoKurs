from django.urls import path

from . import views

urlpatterns = [
    path('/home', views.seller, name='seller_home'),
    path('/pill', views.pill, name='seller_pill'),
    path('/recipe', views.recipe, name='seller_recipe'),
    path('/order', views.order, name='seller_storage')
]