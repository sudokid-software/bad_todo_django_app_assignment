FROM python:3.7

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /src/

RUN pip install --upgrade pip
RUN pip install pipenv
COPY ./Pipfile /src/
RUN pipenv install --skip-lock --system

COPY . /src/
EXPOSE 8000

WORKDIR /src/todo_django_app/

# Run this for no migrations / script
# CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000"]

ENTRYPOINT ["/src/todo_django_app/run.sh"]
