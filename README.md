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
* When the container is created (the first run), you *MUST* set the environment variable ```SETUP_GITOLITE: 1``` to finish the Gitolite configuration process.
* On the subsequent runs, you can unset the environment variable ```SETUP_GITOLITE: 1```.
* Start your services
    ```
    $ docker-compose up -d
    ```
