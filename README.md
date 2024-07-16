# Redmine Docker Container configured with Gitolite and Redmine Git Hosting

Redmine 5.0.9 Docker Image depending on offical Redmine Image, including redmine git hosting and some additional themes and plugins.


## How to use

* Clone this repository
* Add additional plugins into ```plugins``` directory
* Build docker image (gems installation included):
    ```
    $ docker build -t [YOUR-IMAGE-NAME] .
    ```
* Your image is ready for use. Use the official examples using docker-compose to run Redmine.
* Start your services
    ```
    $ docker-compose up -d
    ```
