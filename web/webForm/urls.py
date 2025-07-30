from django.urls import path
from django.shortcuts import redirect
from . import views

app_name = 'webForm'

urlpatterns = [
    path('', lambda request: redirect('add/')),
    path('add/', views.add_entries, name='add_entries'),
    path('list/', views.show_entries, name='show_entries'),
]
