docker build -t ahmedfarouk141414/multi-client:latest -t ahmedfarouk141414/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmedfarouk141414/multi-server:latest -t ahmedfarouk141414/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmedfarouk141414/multi-worker:latest -t ahmedfarouk141414/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahmedfarouk141414/multi-client:latest
docker push ahmedfarouk141414/multi-server:latest
docker push ahmedfarouk141414/multi-worker:latest

docker push ahmedfarouk141414/multi-client:$SHA
docker push ahmedfarouk141414/multi-server:$SHA
docker push ahmedfarouk141414/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahmedfarouk141414/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahmedfarouk141414/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahmedfarouk141414/multi-worker:$SHA
