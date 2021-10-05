curl https://sdk.cloud.google.com | bash
gcloud auth activate-service-account snjallingurxxxx@snjallingurxxxxx.iam.gserviceaccount.com --key-file=/home/homeassistant/.homeassistant/google_sdk.json
gcloud config set account snjallingurxxx@snjallingurxxxxxx.iam.gserviceaccount.com
#managing additional components
#refer to: https://cloud.google.com/sdk/docs/components
gcloud components list
gcloud components install beta
#install Cloud Video Intelligence API
#https://cloud.google.com/video-intelligence/docs/quickstart
#Install Python library
pip install --upgrade google-cloud-videointelligence
