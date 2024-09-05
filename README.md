# Docker and kubernetes practice test Answers 

1. Build fails because by default, package manager operations like apt-get update or yum install require root privileges. So set a USER as root before running any package updates inside a container as defined in the file named ``workingq1.Dockerfile``

2. To run a container in interactive mode use the flag -i and flag -t to allocate a terminal to the container and use -a stdout to attach stdout to the container to make it run in a interactive mode 
`docker run -it -a stdout chainguard/python:latest-dev`

3. Use the flag -p to publish and attach a container port to the host port when running the docker run command 
`docker run -d --name https -p 8000:8000 chainguard/python:latest-dev -m http.server` and then use the curl command to connect to the container from host machine.

3a. Use the docker cp command to quicky copy a file to a running container using containerID

`sudo docker cp index.html 47cf33459b8d:/`

3b. Add a file to a running docker container like above. On a restart the changes will be persistent since when we are copying a file from host to the container it gets copied on the container writable layers which remains persistent even on a restart unless the container is deleted or re-created freshly 
 
The best practice is to add that file to the image in Dockerfile using COPY or ADD command and build it with it


4. The pod is created correctly but the reason why it is not showing up when running the command kubectl get po -n default is because we have specified the namespace name as kube-system explicitly in the pod manifest

4a. If you have created a webserver using the command `kubectl create deployment webserver-test --image nginx --port 80 `then you can expose the deployment as svc using the command `kubectl expose deployment webserver-test `
and then port-forward using the command `kubectl port-forward svc/webserver-test 8080:80` to access it locally. If you expose it to the outside world then you using a `LoadBalancer` service or even better use any `ingress` at layer 7 like `istio or traefik` etc

5. If you want to update it to the existing running deployment/release then use the command helm upgrade and then use the flag `--set image.repository <image-name>` `set image.tag=latest` as below which will do a rolling update of the deployment so there will be no downtime and the release revision will be incremented to 2 

 `helm upgrade website chainguard --set image.repository=chainguard/nginx --set image.tag=latest`
 
6. The main differences between a internal repo and public repo will be the access control and repo settings. The difference between a FORK and branch is as follows 

FORK: A fork creates a new repository under your account or organization. Your forked repository is visible only to you. This repository is separate from the original one, so you have full control over your forked repository. You can modify, delete, or manage branches within your fork without affecting the original repository

Branch: Branches are managed within a single repository. Permissions to create, modify, or delete branches depend on the user’s role in the repository.Users with write access to the repository can create, push to, and delete branches. Branches are visible to all users with access to the repository. If you have access to a repository, you can see all its branches and the changes made in them.