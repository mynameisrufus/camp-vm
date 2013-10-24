# Campers VM FTW

Features:

* gems (done)
* npm
* tweeter

add a new module:

```
puppet module install ripienaar/concat --modulepath modules
```

## Gem mirror

```
vagrant ssh
cd ~/rubygems-mirror/
rake mirror:update
```

## NPM mirror

```
 curl -X POST http://127.0.0.1:5984/_replicate -d '{"source":"http://isaacs.iriscouch.com/registry/", "target":"registry", "continuous":true, "create_target":true}' -H "Content-Type: application/json"
```

Should return:

```
{"ok":true,"_local_id":"d0818878c462afa6791440ab08348394+continuous+create_target"}
```

Check the status:

```
curl -X GET http://127.0.0.1:5984/_all_dbs
curl -X GET http://127.0.0.1:5984/registry
```
