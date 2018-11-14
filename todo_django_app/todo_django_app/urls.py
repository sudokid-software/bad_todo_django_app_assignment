from django.contrib import admin
from django.urls import path
# from django.urls import path, include

# from rest_framework.routers import DefaultRouter

from api.views import TodoView, TodoViewSingle


# router = DefaultRouter()
# router.register('todo', TodoViewSet, base_name='todo')

urlpatterns = [
    path('api/todo/', TodoView.as_view()),
    path('api/todo/<int:pk>/', TodoViewSingle.as_view()),
    path('admin/', admin.site.urls),
]
