docker build -t valmuadib/multi-client:latest -t valmuadib/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t valmuadib/multi-server:latest -t valmuadib/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t valmuadib/multi-worker:latest -t valmuadib/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push valmuadib/multi-client:latest
docker push valmuadib/multi-server:latest
docker push valmuadib/multi-worker:latest

docker push valmuadib/multi-client:$SHA
docker push valmuadib/multi-server:$SHA
docker push valmuadib/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployement server=valmuadib/multi-server:$SHA
kubectl set image deployments/client-deployement client=valmuadib/multi-client:$SHA
kubectl set image deployments/worker-deployement worker=valmuadib/multi-worker:$SHA