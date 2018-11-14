from rest_framework.views import APIView
from rest_framework.response import Response

from .models import Todo
from .serializers import TodoSerializer


class TodoView(APIView):
    """
    2. Delete one or more TODOs.
    3. Update one or more TODOs.
    4. List all TODOs.
    a. Able to filter TODOs by state and/or due-date.
    """
    serializer_class = TodoSerializer

    @staticmethod
    def get_queryset(request):
        state = request.query_params.get('state', None)
        due_date = request.query_params.get('due-date', None)

        if state and due_date:
            return Todo.objects.filter(state=state, due_date=due_date)

        if state:
            return Todo.objects.filter(state=state)

        if due_date:
            return Todo.objects.filter(due_date=due_date)

        return Todo.objects.all()

    def get(self, request):
        todos = self.get_queryset(request)
        todos_serialized = self.serializer_class(todos, many=True)
        return Response(todos_serialized.data, 200)

    @staticmethod
    def post(request):
        data = request.data

        if not isinstance(data, list):
            return Response({'error': 'Invalid request'}, status=400)

        todos_created = []
        for todo in data:
            new_todo = TodoSerializer(data=todo)
            if not new_todo.is_valid():
                return Response(new_todo.errors, status=400)
            new_todo.save()
            todos_created.append(new_todo.data)

        return Response(todos_created, status=200)

    @staticmethod
    def delete(request):
        todo_list = request.data
        todos = Todo.objects.filter(pk__in=todo_list)

        if len(todos) == 0:
            return Response({'error': 'Not found', 'todos': todo_list}, status=404)

        todos_serialized = TodoSerializer(todos, many=True).data
        [todo.delete() for todo in todos]
        return Response(todos_serialized, status=200)

    @staticmethod
    def patch(request):
        todo_list = request.data

        if not isinstance(todo_list, list):
            return Response({'error': 'Invalid request'}, status=400)

        todos_updated = []
        for todo in todo_list:
            pk = todo.get('id', False)
            if not pk:
                continue

            try:
                todo_record = Todo.objects.get(pk=pk)
                todo_update = TodoSerializer(todo_record, data=todo, partial=True)
                if todo_update.is_valid():
                    todo_update.save()
                    todos_updated.append(todo_update.data)
            except Todo.DoesNotExist:
                continue

        return Response(todos_updated, status=200)


class TodoViewSingle(APIView):
    @staticmethod
    def get(request, pk=None):
        try:
            todo = Todo.objects.get(pk=pk)
        except Todo.DoesNotExist:
            return Response({'error': 'Not found'}, status=404)

        todo_serialized = TodoSerializer(todo, many=False)
        return Response(todo_serialized.data, status=200)
