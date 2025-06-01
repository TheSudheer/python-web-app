FROM python:3.11-slim

ENV #Framework
SECRET_KEY='<secret key>'
DEBUG=true
APP_ENV=local #use one of local/sit/uat/prod

#Email
EMAIL_HOST='<Host>'
EMAIL_PORT=587
EMAIL_USE_TLS=true
EMAIL_HOST_USER='<email address>'
EMAIL_HOST_PASSWORD='<pwd>'

#Database
DATABASE_NAME=<db name>
DATABASE_USER=root
DATABASE_PASSWORD=
DATABASE_HOST=localhost
DATABASE_PORT=3306
DB_ROOT_PASSWORD=
 
#Timezone
LANGUAGE_CODE='en-us'
TIME_ZONE='UTC'
USE_I18N=true
USE_TZ=true

#API
CORS_ORIGIN_ALLOW_ALL=false

#Media
BASE_URL='<base url>'

#MSAL CRED
#MS_EMAIL = '<email>'
#TENANT_ID = '<TENANT_ID>'
#CLIENT_ID = '<CLIENT_ID>'
#CLIENT_SECRET = '<CLIENT_SECRET>'

MS_EMAIL = '<MS_EMAIL>'
TENANT_ID = '<TENANT_ID>'
CLIENT_ID = '<CLIENT_ID>'
CLIENT_SECRET = '<CLIENT_SECRET>'

WHATSAPP_ID='<WHATSAPP_ID>'
WHATSAPP_API_KEY='<WHATSAPP_API_KEY>'

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY . .
 

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
