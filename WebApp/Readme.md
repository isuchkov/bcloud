Push the image you built to the ACR:

az acr login --name <your-acr-name>
docker tag hello-world-app <your-acr-name>.azurecr.io/hello-world-app:v1
docker push <your-acr-name>.azurecr.io/hello-world-app:v1


az acr login --name <your-acr-name>
docker run -p 5000:5000 <your-acr-name>.azurecr.io/hello-world-app:v1
