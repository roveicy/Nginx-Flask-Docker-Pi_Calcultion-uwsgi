# Nginx-Flask-Docker-Pi_Calcultion-uwsgi
The docker compose file which provides calculation of pi and simulation of the number of users using Apache benchmark tool. The docker-compose includes Nginx-Flask-Docker-unsgwi
In order to run the file, we will follow the instructions below:
1)docker-compose build "this will build docker images"
2)docker-compose create "this will create docker conainers"
3)docker-compose -d "to start the docker-compose and run it"
4)docker-compose exec web curl http://127.0.0.1/20 "this is the url that we set for calculation of the '20' digits of Pi we can change the number of digits from 20 to any other numbers "

