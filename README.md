# Node & Express Demo App for Azure DevOps

> Build Your First CI/CD Pipeline using Azure DevOps with this Demo App.

This is a Node and Express web application used to demonstrate CI/CD with Azure DevOps. You can clone this repo and use it within Azure DevOps to build, test, and release to an Azure App Service web app.

## Running and Testing Locally:

You can use these commands to install, test, and run the app locally. (Not Required)

### Install

```
npm install 
npm install -g mocha
npm install -g mocha-junit-reporter
npm install -g nyc
```

### Test

```
npm test

#For unit tests using mocha
mocha test/test.js --reporter mocha-junit-reporter --reporter-options mochaFile=testresults.xml --exit

#For coverage
nyc --reporter cobertura --reporter html mocha test/test.js --reporter mocha-junit-reporter --reporter-options mochaFile=testresults.xml --exit
```

Navigate to the `/test` folder to review the unit tests for this project. These tests will run as part of your Azure DevOps Build pipeline. See `azure-pipelines.yml` in this repo.

### Start

```
npm start
```
### Docker image build
```
docker build -t techsummit --build-arg VERSION=1 -f Dockerfile.prod .
docker build -t techsummit-test -f Dockerfile.test .
```
### Docker Container Run
```
#This will run unit tests inside the container and remove the container after tests finished.
docker run --rm --name techsummit-test techsummit-test
#This will start the application. Run and open your browser, type http://localhost:3000 and enjoy!
docker run --name techsummit techsummit
```
### Author

Hakki Ogretmen
[@hakki_ogretmen](https://twitter.com/hakki_ogretmen)

### Version

2.0.0

### License

This project is licensed under the Apache License 2.0

Thank you Mike Pfeiffer for the first version of the code.
[@mike_pfeiffer](https://twitter.com/mike_pfeiffer)
