# Gilded Rose Kata in Ruby

## Introduction

This refactoring exercise showcases key software engineering principles such as abstraction, encapsulation, dependency injection, and test-driven development. My goal was to highlight my approach to system design and the decision-making process I follow as a software engineer. 

### Ruby Files

There are 2 files in the __/lib__ directory
- gilded_rose_refactor_me.rb (the original ruby file that needs to be refactored)
- gilded_rose.rb (the ruby file that has been refactored)
  
## Usage

I have created and pushed a public docker image to allow quick and easy use ```docker pull jwipeout/rose_kata```

If you are familiar with docker-compose, you can simply clone the github repo and run in the root directory 

```
docker-compose up -d
``` 

If you would like to volume your local computer repo to the container you can uncomment the volumes section in the [docker-compose.yml](https://github.com/jwipeout/rose_kata/blob/master/docker-compose.yml#L5) and replace the ```~/code/rose_kata``` path with the path of your local computer rose_kata repo.

A docker container will be created. You can view the container with

```
docker ps
```

then you can exec into the container with

```
docker exec -i -t rose_kata-rose_kata-1 bash
```

## Tests

You can run tests using rspec

