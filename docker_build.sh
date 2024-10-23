docker build --platform linux/amd64 -t zelda3_git_runner -f docker/Dockerfile .
docker run --rm -it --name z3_runner zelda3_git_runner