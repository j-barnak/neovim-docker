#  Development


Build and run:

```
docker build -t kernel .
docker run -it --mount src="$(pwd)",target=/linux,type=bind kernel
```
