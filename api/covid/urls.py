
from django.urls import path

from . import views

# List endpoints of the API
urlpatterns = [
    path('people/', views.PeopleView.as_view()),
    path('people/<int:id>/', views.PeopleView.as_view()),
    path('people/<str:detailed>/', views.PeopleView.as_view()),
    path('people/<int:people_id>/', views.PeopleView.as_view())
]