
# Build and run

```
docker build --no-cache -t willow -f Dockerfile .
docker run -p 80:80 -d --name="willow_server" willow
docker ps
```

Go to command line of running container
```
docker exec -it willow_server bash
```

Delete container using name
```
docker rm -f willow_server
```