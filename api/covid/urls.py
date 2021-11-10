
from django.urls import path

from . import views

urlpatterns = [
    path('people/', views.PeopleView.as_view()),
    path('people/<int:id>/', views.PeopleView.as_view()),
    path('people/<str:detailed>/', views.PeopleView.as_view())
]