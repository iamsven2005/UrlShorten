# url-shortener-microservice
My FreeCodeCamp url-shortener-microservice exercise solution in Common Lisp (caveman2), Vue.js front-end framework and a little bit of SweetAlert2 popup box

## Usage
* `(ql:quickload :url-shortener-microservice)`
* Launch a local web development server ***hunchentoot*** at port 3000 - `(url-shortener-microservice:start :port 3000)`
* Launch and navigate your web browser to http://localhost:3000
* Enjoy! :)

## User Story
1. I can POST a URL to [project_url]/api/shorturl/new and I will receive a shortened URL in the JSON response.
Example : {"longUrl":"www.google.com","shortUrl":1}
2. If I pass an invalid URL that doesn't follow the http(s)://www.example.com(/more/routes) format, the JSON response will contain an error like {"error":"invalid URL"}
HINT: to be sure that the submitted url points to a valid site you can use the function dns.lookup(host, cb) from the dns core module.
3. When I visit the shortened URL, it will redirect me to my original link.


## Example API Usage
* GET http://localhost:3000/api/shorturl/3
  - will redirect to https://github.com for example
* POST http://localhost:3000/api/shorten/new
  - example: POST [project_url]/api/shorturl/new - https://www.google.com

## Installation
1. `git clone https://github.com/momozor/FCC-url-shortener-microservice`
2. Load the project with Quicklisp - `(ql:quickload :url-shortener-microservice)`

## Deploying with Heroku
* Make sure you have registered with Heroku, and downloaded Heroku's CLI, and already ran
`heroku login`

1. `heroku create`
2. `heroku stack:set container`
3. make your changes
4. `git add .; git commit`
5. `git push heroku master`
6. Open the deployed app with `heroku open` (will launch a browser to app on heroku)

## Todo
* actually encode the short urls instead of just using
id

## Authors
* momozor

## License
This project is licensed under the MIT license. See LICENSE file for more details.
