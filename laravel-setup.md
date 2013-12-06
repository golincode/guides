Laravel
=======

### Installing

#### Creating A New Project

To set up a new laravel project, run

```bash
composer create-project laravel/laravel projectname
```

( This will run `composer install` for you )

#### Setup

###### Composer

Clone your project, then run

```bash
composer install
```

###### Permissions

Set the permissions of the storage directory

```bash
chmod -R 777 app/storage
```

###### Environment

Set your environment in `bootstrap/start.php` (you can find out your machine name by running `hostname` on the command line), **then assume unchanged this file**

###### Database

Duplicate `app/config/database.php` into `app/config/local/database.php`, and fill in your database details.

```bash
php artisan migrate
```

###### Production

If this is a production environment, you can precompile autoloaded files with the command

```bash
php artisan optimize
```
