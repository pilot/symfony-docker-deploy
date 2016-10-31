Dockerized Symfony app
======================

How to auto deploy test-green docker base symfony application to the Elastic Beanstalk

**Presentation Slides**

http://www.slideshare.net/redpilot/auto-deploy-symfony-app-with-codeship-and-elastic-beanstalk

### first run 

- be sure that you install **docker** and **docker-compose**
- clone the project
- get in project folder
- stop your local web server if any as our app takes the 80 port
- build the containers `docker-compose build`
- run the containers `docker-compose up -d`
- check that's containers up `docker-compose ps`
- install symfony vendors `docker exec -ti symfony_app composer install`
- open browser `http:/localhost/app_dev.php` you should standard Symfony CAMP UA welcome screen
- finally setup your own repository to push code back to the github.com for later auto deploy

![sfcampua](https://cloud.githubusercontent.com/assets/28564/19847481/e59db9a0-9f4f-11e6-8ad9-43629b0a40b7.png)

### configure codeship.com CI for test and auto deploy

- I suppose you already have codeship.com account
- connect your github.com account with codeship.com, then choose your version of this repo
- configure project setup commands

![codeship-setup](https://cloud.githubusercontent.com/assets/28564/19847824/20f86f2a-9f52-11e6-914b-e5a36bb402b9.png)

```yml
# <- this is a comment and won't be executed
# Feel free to delete all the comments and type in your own commands
# Each line is treated like a command that you execute in a local shell.
# i.e.: rvm use 2.2.2
# i.e.: bundle install
# Set Environment Vars for Symfony test
export SYMFONY_ENV=test
export SYMFONY__TEST_DATABASE_USER=$MYSQL_USER
export SYMFONY__TEST_DATABASE_PASSWORD=$MYSQL_PASSWORD
export SYMFONY__TEST_DATABASE_NAME=test
# Copy the parameters.yml.dist
cp app/config/parameters.yml.dist app/config/parameters.yml
# Install dependencies through Composer
composer install --prefer-source --no-interaction
# Clear Cache
php ./bin/console --env=test cache:clear
```

- configure tests run commands

![codeship-setup-tests](https://cloud.githubusercontent.com/assets/28564/19847857/459a1e5a-9f52-11e6-8f17-5d97142b75e4.png)

```yml
# <- this is a comment and won't be executed
# Feel free to delete all the comments and type in your own commands
# Each line is treated like a command that you execute in a local shell.
# i.e.: rvm use 2.2.2
# i.e.: bundle install
phpunit -c ./
```

- push any changes in current README.md file to your repo, just for initiate CI tests run

![codeship-test-run](https://cloud.githubusercontent.com/assets/28564/19847869/655ebb2e-9f52-11e6-8aea-258207c06963.png)

### Create application on Elastic Beanstalk 

![elastic-beanstalk](https://cloud.githubusercontent.com/assets/28564/19847939/d7aed088-9f52-11e6-8091-a0f5387b5b8c.png)

![image](https://cloud.githubusercontent.com/assets/28564/19848040/7da4ced4-9f53-11e6-8066-671d8659e3bb.png)

![image](https://cloud.githubusercontent.com/assets/28564/19848043/82f84d16-9f53-11e6-94d8-97a2069aaa10.png)

- finally you should get successful application setup screen

![elastic-beanstalk-app](https://cloud.githubusercontent.com/assets/28564/19848051/87989ca4-9f53-11e6-9ec5-ca190092d6ac.png)

- at the top of screen you find the your new app url like http://default-environment.q45ve7ct8n.eu-central-1.elasticbeanstalk.com/

### Setup Elastic Beanstalk CLI on your local machine

- setup Elastic Beanstalk **eb** CLI command, follow the official manual http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html
- check that alright `eb --version`
- init your project `eb init`

### Auto deploy your app

- going back to the http://codeship.com -> **project settings**, then choose **deployment** section

![image](https://cloud.githubusercontent.com/assets/28564/19848341/b29b2456-9f55-11e6-92c2-97051c4d2ec7.png)

![image](https://cloud.githubusercontent.com/assets/28564/19848343/b768af80-9f55-11e6-8bdf-5c34fc3a5be5.png)

- that's all, just make another changes in README.md file, then push to the master
- waiting until the test a green, then follow the magic of codeship.com deploy to the elastic beanstalk app
- open url of you elastic beanstalk app like http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html
- voila! 

### for Questions 

- for any questions create an issue 

### License

- all what you can find at this repo shared under the MIT License






