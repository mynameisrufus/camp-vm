# Campers VM FTW

Features:

* gems (done)
* npm
* tweeter

add a new module:

```
puppet module install ripienaar/concat --modulepath modules
```

Gem mirror

```
vagrant ssh
cd ~/rubygems-mirror/
rake mirror:update
```
