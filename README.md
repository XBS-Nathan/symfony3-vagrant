## What's in the box?

- Ubuntu 15.10 (Wily)
 
- Git
- cURL
- MariaDB
  * Username: `root`
  * Password: `password`
- SQLite
- nginx
- PHP
- PHP-FPM
- PEAR
- XDebug
- RabbitMQ
  * Username: `admin`
  * Password: `password`
- Memcached

Additionally, it will create a MySQL database called `symfony`.

### Usage

```
$ cd your-symfony-project
$ git clone https://github.com/XBS-Nathan/vagrant-symfony.git vagrant
```

Or, if you're using Git already in your project, you can use it as a submodule:

```
$ cd your-symfony-project
$ git submodule add https://github.com/XBS-Nathan/vagrant-symfony.git vagrant
```

After the project is added, you can start the environment like this:

```
$ cd vagrant
$ vagrant up
```

### Access 

[http://192.168.33.10](http://192.168.33.10) 

