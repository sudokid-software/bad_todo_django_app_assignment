FROM python:3.6.7

RUN pip install pipenv

COPY . /src/.
WORKDIR /src/
RUN pipenv install
RUN pipenv install --system --deploy

WORKDIR /src/todo_django_app
RUN python manage.py migrate

EXPOSE 8000:8000
CMD ["bash", "run.sh"]

