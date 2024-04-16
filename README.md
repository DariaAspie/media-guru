# MEDIA GURU
The primary objective of the web application is to furnish a sophisticated tool tailored for the systematic organization of video content belonging to Innovation and Solutions Factory LLC. This innovative application is meticulously crafted to not only house, regulate, and process video materials but also to facilitate seamless accessibility and manipulation for both average users and administrators.

The developmental aspiration is to engineer a robust and user-friendly platform dedicated to the meticulous organization and utilization of video content. This entails proficiently storing, administrating, analyzing, and granting access to video resources, catering to the needs of both regular users and administrators alike.
<br>
*В этом проекте беда с чистотой кода, так как это КУРСАЧ, у преподов свои дибильные требования к коду, которые приходилось соблюдать*

# Getting started

Before we start you must be sure that you have installed:

- [RVM](http://rvm.io/rvm/install)
- [Ruby 3.2.2](https://gist.github.com/pboksz/4649025)
- [Ruby on Rais 7+ version](https://guides.rubyonrails.org/v5.1/getting_started.html)
- [PostgreSQL](https://www.postgresql.org/docs/current/tutorial-install.html)
- [Docker](https://docs.docker.com/engine/install/)
- [Npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stablehttps://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)

## Installation
You can clone an existing repository from GitHub.com to your local computer, or to a codespace:

```sh
   $ git clone https://github.com/DariaAres/media-guru.git
```

## Configure

1. Change directory to `media-guru`:

    ```sh
    $ cd media-guru
    ```

1. Installing dependencies:

    ```sh
    $ sudo apt install -yqq libpq-dev
    $ gem install bundler
    $ bundle install
    $ yarn install
    $ yarn run build
    ```

1. You can go to `.env` file to change user and connect to database, where `POSTGRES_USER` is a username that you created to authenticate in MySQL; `POSTGRES_PASSWORD` is the password with which your `POSTGRES_USER` can authenticate:

    ```sh
        POSTGRES_USER = username
        POSTGRES_PASSWORD = password
    ```

1. Then you should create the databases defined in the current environment, run pending migrations and fill the current database with data defined in `db/seeds.rb`:

    ```sh
    $ rails db:create db:migrate db:seed
    ```

## Usage

- ### Start the web server locally

    This command launches a web server named Puma which comes bundled with Rails:

    ```sh
    $ rails s
    ```
    You'll use this any time you want to access your application through a web browser.

    Run with `--help` or `-h` for options.

- ### Start the web server with docker
    First of all, you need to build the project into an image file:

    ```sh
    $ docker compose build
    ```

    Now that the project is built, it's time to run it. This step of our work corresponds to the step where, when working with individual containers, the `docker run` command is executed:

    ```sh
    $ docker compose up
    ```
    Run with `--help` or `-h` for options.

## Database
![Снимок экрана 2024-03-23 142610](https://github.com/DariaAres/media-guru/assets/120682364/5c1e0466-6af8-4d13-a8c6-b4ccad71970f)
https://app.sqldbm.com/PostgreSQL/DatabaseExplorer/p293197/


## License

This code is free to use under the terms of the MIT license.
