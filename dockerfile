FROM python:3.11

# Установка Node.js и npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

# Копируем файлы зависимостей
COPY requirements.txt .
COPY package.json package-lock.json ./

# Устанавливаем зависимости Python и Node.js
RUN pip install -r requirements.txt
RUN npm install

# Копируем остальные файлы проекта
COPY . .

# Собираем Tailwind CSS
RUN python manage.py tailwind install
RUN python manage.py tailwind build

# Собираем статические файлы
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]